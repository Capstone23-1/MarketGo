import SwiftUI
import Alamofire

struct MarketReviewView: View {
    @StateObject private var viewModel = MarketReviewViewModel()
    @EnvironmentObject var marketModel: MarketModel
    @EnvironmentObject var userModel: UserModel
    @State private var isWritingReview = false

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    if let reviews = viewModel.marketReviews {
                        ForEach(reviews) { review in
                            MarketReviewRow(review: review, viewModel: viewModel) // Pass viewModel as a parameter
                                .environmentObject(userModel)
//                                .environmentObject(marketModel)
                        }
                    } else {
                        ProgressView()
                    }
                }
            }
            .padding()
            
            NavigationLink(destination: MarketReviewPostView(), isActive: $isWritingReview) {
                EmptyView()
            }
            
            Button(action: {
                isWritingReview = true
            }, label: {
                Text("\(userModel.currentUser?.interestMarket?.marketName ?? "") 리뷰 작성")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(30)
                    
            })
            .padding([.leading, .bottom, .trailing], 10)
        }
        .onAppear {
            viewModel.fetchMarketReviews(for: userModel.currentUser?.interestMarket?.marketID ?? 0)
        }
    }
}

struct MarketReviewRow: View {
    let review: MarketReviewElement
    @State private var image: UIImage? = nil
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var marketModel: MarketModel
    let viewModel: MarketReviewViewModel // Add viewModel as a parameter
    
    @State private var showEditAlert = false // Add separate state for showing the edit alert
    @State private var showDeleteAlert = false // Add separate state for showing the delete alert
    
    @State private var deleteReviewId: Int? // Add state for tracking the review to be deleted
    @State private var editReviewId: Int? // Add state for tracking the review to be edited
    @State private var isEditingReview = false // Add state for showing/hiding the MarketReviewPutView
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("\(review.ratings ?? 0)점")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(5)
                    .background(Color.yellow)
                    .cornerRadius(10)
                
                HStack(spacing: 0) {
                    ForEach(0..<5) { index in
                        Image(systemName: "star.fill")
                            .foregroundColor(index < (review.ratings ?? 0) ? .yellow : .gray)
                    }
                }
                .padding(.leading, 5)
                .padding(.trailing, 2)
                Text(review.mrMemberID?.memberName ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Edit button
                NavigationLink(destination: MarketReviewPutView(marketReviewId: review.marketReviewID ?? 0, viewModel: viewModel, ratings: Double(review.ratings ?? 0),reviewContent: review.reviewContent ?? "", fileId: review.marketReviewFile?.fileID ?? 0), isActive: $isEditingReview) {
                    EmptyView()
                }
                .hidden()
                if let currentUser = userModel.currentUser, let memberID = review.mrMemberID?.memberID, currentUser.memberID == memberID {
                    
                    HStack{
                        Button(action: {
                            if let currentUser = userModel.currentUser, let memberID = review.mrMemberID?.memberID, currentUser.memberID == memberID {
                                editReviewId = review.marketReviewID
                                isEditingReview = true // Set the state to show the MarketReviewPutView
                            } else {
                                // Show permission error alert
                                // You can customize the alert message here
                                showEditAlert = true
                            }
                        }, label: {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                        })
                        .alert(isPresented: $showEditAlert, content: {
                            return Alert(
                                title: Text("권한 오류"),
                                message: Text("리뷰 수정 권한이 없습니다."),
                                dismissButton: .default(Text("확인"))
                            )
                        })
                        
                        
                        
                        // Delete button
                        Button(action: {
                            if let currentUser = userModel.currentUser, let memberID = review.mrMemberID?.memberID, currentUser.memberID == memberID {
                                showDeleteAlert = true
                                deleteReviewId = review.marketReviewID
                            } else {
                                // Show permission error alert
                                // You can customize the alert message here
                                showDeleteAlert = true
                            }
                        }, label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        })
                        .alert(isPresented: $showDeleteAlert, content: {
                            if deleteReviewId != nil {
                                return Alert(
                                    title: Text("확인"),
                                    message: Text("리뷰를 삭제하시겠습니까?"),
                                    primaryButton: .default(Text("삭제"), action: {
                                        deleteMarketReview(with: deleteReviewId!, viewModel: viewModel) // Pass viewModel as a parameter
                                    }),
                                    secondaryButton: .cancel(Text("취소"), action: {})
                                )
                            } else {
                                return Alert(
                                    title: Text("권한 오류"),
                                    message: Text("리뷰 삭제 권한이 없습니다."),
                                    dismissButton: .default(Text("확인"))
                                )
                            }
                        })
                    }
                }
                
              
            }
            .padding(.leading, 5)
            
            if let dateString = review.reviewDate,
               let date = extractDate(from: dateString) {
                let formattedDate = formatDate(date)
                
                Text("작성일: \(formattedDate)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(5)
                    .padding(.top, 3)
            }
            
            
            Text(review.reviewContent ?? "")
                .font(.body)
                .padding(.leading, 5)
            
            VStack(alignment: .leading) {
                RemoteImage2(url: URL(string: review.marketReviewFile?.uploadFileURL ?? ""))
            }
            .padding(.leading, 5)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2, y: 1)
    }
    
    func deleteMarketReview(with marketReviewId: Int, viewModel: MarketReviewViewModel) {
        let urlString = "http://3.34.33.15:8080/marketReview?marketReviewId=\(marketReviewId)"
        
        AF.request(urlString, method: .delete).response { response in
            switch response.result {
            case .success:
                print("Market review deleted successfully.")
                    viewModel.fetchMarketReviews(for: userModel.currentUser?.interestMarket?.marketID ?? 0) // Fetch updated reviews
            case .failure(let error):
                print("Error deleting market review: \(error)")
            }
        }
    }
    
    private func extractDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            return Calendar.current.startOfDay(for: date)
        }
        return nil
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: date)
    }
}
