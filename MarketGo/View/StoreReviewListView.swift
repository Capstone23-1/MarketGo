import SwiftUI
import Alamofire

struct StoreReviewListView: View {
    let store: StoreElement
    @StateObject private var viewModel = TestViewModel()
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        VStack {
            Text("\(store.storeName ?? "") Review")
                .font(.title3)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                LazyVStack {
                    if let reviews = viewModel.reviews {
                        ForEach(reviews) { review in
                            ReviewRow(review: review, viewModel: viewModel, store: store)
                        }
                    } else {
                        ProgressView()
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchReviews(for: store.storeID ?? 0)
        }
    }
}

struct ReviewRow: View {
    let review: StoreReviewElement
    @State private var image: UIImage? = nil
    let viewModel: TestViewModel
    let store: StoreElement
    @EnvironmentObject var userModel: UserModel
    
    @State private var showAlert = false // Add state for showing the alert
    @State private var deleteReviewId: Int? // Add state for tracking the review to be deleted
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("\(review.ratings ?? 0)점")
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .background(Color.yellow)
                    .cornerRadius(10)
                
                HStack(spacing: 0) {
                    ForEach(0..<5) { index in
                        Image(systemName: "star.fill")
                            .foregroundColor(index < (review.ratings ?? 0) ? .yellow : .gray)
                    }
                }
                .padding(.leading, 5)
                
                Text(review.memberID?.memberName ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Edit button
                Button(action: {
                    // Check if the user has permission to delete the review
                    if let currentUser = userModel.currentUser, let memberID = review.memberID?.memberID, currentUser.memberID == memberID {
                        showAlert = true
                        deleteReviewId = review.storeReviewID
                    } else {
                        // Show permission error alert
                        // You can customize the alert message here
                        showAlert = true
                    }
                }, label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                })
                .alert(isPresented: $showAlert, content: {
                    if deleteReviewId != nil {
                        return Alert(
                            title: Text("확인"),
                            message: Text("리뷰를 삭제하시겠습니까?"),
                            primaryButton: .default(Text("삭제"), action: {
                                deleteStoreReview(with: review.storeReviewID ?? 0, viewModel: viewModel, store: store)
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
            
            Text(review.reviewContent ?? "")
                .font(.body)
                .padding(.horizontal, 1)
                .padding(.vertical, 7)
            
            VStack(alignment: .leading) {
                RemoteImage2(url: URL(string: review.storeReviewFile?.uploadFileURL ?? ""))
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2, y: 1)
    }
}

func deleteStoreReview(with reviewId: Int, viewModel: TestViewModel, store: StoreElement) {
    let url = "http://3.34.33.15:8080/storeReview?storeReviewId=\(reviewId)"
    
    AF.request(url, method: .delete).response { response in
        switch response.result {
        case .success:
            // Handle successful deletion
            // You can update the view or perform any other actions
            // For example, you can refetch the reviews
            viewModel.fetchReviews(for: store.storeID ?? 0)
        case .failure(let error):
            print("Failed to delete store review: \(error)")
        }
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
