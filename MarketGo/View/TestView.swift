import SwiftUI
import Alamofire


struct StoreReviewTestView: View {
    @StateObject private var viewModel = StoreReviewViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let storeReviews = viewModel.storeReviews {
                ForEach(storeReviews) { review in
                    Text(review.reviewContent ?? "")
                }
            } else {
                Text("No reviews found")
            }
        }
        .onAppear {
            viewModel.fetchStoreReviews()
        }
    }
}

struct StoreReviewTestView_Previews: PreviewProvider {
    static var previews: some View {
        StoreReviewTestView()
    }
}

class StoreReviewViewModel: ObservableObject {
    @Published var storeReviews: [StoreReviewElement]?
    @Published var isLoading = false
    
    func fetchStoreReviews() {
        isLoading = true
        
        let url = URL(string: "http://3.34.33.15:8080/storeReview/all")!
        
        AF.request(url).responseDecodable(of: StoreReview.self) { response in
            self.isLoading = false
            
            if case .success(let storeReviews) = response.result {
                self.storeReviews = storeReviews
            }
        }
    }
}
