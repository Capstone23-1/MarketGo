import SwiftUI
import Alamofire
//StoreReviewListView
//let store: StoreElement
//@StateObject private var viewModel = TestViewModel()
//@EnvironmentObject var userModel: UserModel
//Row
//let review: StoreReviewElement
//@State private var image: UIImage? = nil
//let viewModel: TestViewModel
//let store: StoreElement
//@EnvironmentObject var userModel: UserModel


struct StoreReviewListView: View {
    @StateObject private var viewModel = TestViewModel()
    @EnvironmentObject var userModel: UserModel
    @State private var isWritingReview = false
    let store: StoreElement


    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    if let reviews = viewModel.reviews {
                        ForEach(reviews) { review in
                            StoreReviewRow(store: store, review: review, viewModel: viewModel) // Pass viewModel as a parameter
                                .environmentObject(userModel)
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
            
        }
        .onAppear {
            viewModel.fetchReviews(for: store.storeID ?? 0)
        }
    }
}


struct StoreReviewRow: View {
    let store: StoreElement
    let review: StoreReviewElement
    let viewModel: TestViewModel // Add viewModel as a parameter
    
    @State private var image: UIImage? = nil
    @EnvironmentObject var userModel: UserModel
    
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
                
                Text(review.memberID?.memberName ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
//                NavigationLink(destination: EditStoreReviewView(storeReviewId: review.storeReviewID?? 0, viewModel: viewModel, ratings: Double(review.ratings ?? 0),reviewContent: review.reviewContent ?? "", fileId: review.marketReviewFile?.fileID ?? 0), isActive: $isEditingReview) {
//                let storeReviewId: Int
//                let storeId: Int
//                let viewModel: TestViewModel
//
//                @State var ratings: Double = 0.0
//                @State var reviewContent: String = ""
//                @State var fileId: Int = 113
            
                // Edit button
                NavigationLink(destination: EditStoreReviewView(storeReviewId: review.storeReviewID ?? 0, storeId : store.storeID ?? 0, viewModel: viewModel, ratings: Double(review.ratings ?? 0),reviewContent: review.reviewContent ?? "", fileId: review.storeReviewFile?.fileID ?? 0), isActive: $isEditingReview) {
                    EmptyView()
                }
                .hidden()
                if let currentUser = userModel.currentUser, let memberID = review.memberID?.memberID, currentUser.memberID == memberID {
                    
                    HStack{
                        Spacer()
                        VStack{
                            Button(action: {
                                if let currentUser = userModel.currentUser, let memberID = review.memberID?.memberID, currentUser.memberID == memberID {
                                    editReviewId = review.storeReviewID
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
                        }
                        Spacer()
                        VStack{
                            // Delete button
                            Button(action: {
                                if let currentUser = userModel.currentUser, let memberID = review.memberID?.memberID, currentUser.memberID == memberID {
                                    showDeleteAlert = true
                                    deleteReviewId = review.storeReviewID
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
                                            deleteStoreReview(with: deleteReviewId!, viewModel: viewModel, store: store) // Pass viewModel as a parameter
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
                        Spacer()

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
                RemoteImage2(url: URL(string: review.storeReviewFile?.uploadFileURL ?? ""))
            }
            .padding(.leading, 5)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2, y: 1)
    }
    
    
    
    func deleteStoreReview(with reviewId: Int, viewModel: TestViewModel, store: StoreElement) {
        let url = "http://3.34.33.15:8080/storeReview?storeReviewId=\(reviewId)"
        
        AF.request(url, method: .delete).response { response in
            switch response.result {
            case .success:
                
                print("store review deleted successfully.")
                viewModel.fetchReviews(for: store.storeID ?? 0) //삭제 후fetch
                
            case .failure(let error):
                print("Failed to delete store review: \(error)")
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




class TestViewModel: ObservableObject {
    @Published var reviews: [StoreReviewElement]?
    @Published var isLoading = false

    func fetchReviews(for storeId: Int) {
        isLoading = true

        let url = "http://3.34.33.15:8080/storeReview/storeId/\(storeId)"
        AF.request(url).responseDecodable(of: StoreReview.self) { response in
            defer { self.isLoading = false }

            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.reviews = data
                }
            case .failure(let error):
                print("Failed to fetch reviews: \(error)")
            }
        }
    }
}
