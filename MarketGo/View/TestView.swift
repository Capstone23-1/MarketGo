import SwiftUI
import Alamofire

struct TestView: View {
    @StateObject private var viewModel = TestViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let reviews = viewModel.reviews {
                List(reviews) { review in
                    Text(review.reviewContent ?? "")
                }
            } else {
                Text("No reviews found")
            }
        }
        .onAppear {
            viewModel.fetchReviews(for: 9) // Replace 9 with the desired storeId
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
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
