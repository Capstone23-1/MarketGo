import SwiftUI

struct TestView: View {
    @StateObject private var viewModel = TestViewModel()
    let storeId: Int
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                if let reviews = viewModel.reviews {
                    List(reviews, id: \.storeReviewID) { review in
                        VStack(alignment: .leading) {
                            Text("Review ID: \(review.storeReviewID ?? 0)")
                            Text("Member Name: \(review.memberID?.memberName ?? "")")
                            Text("Ratings: \(review.ratings ?? 0)")
                            Text("Review Content: \(review.reviewContent ?? "")")
                            // Display other relevant review information
                        }
                        .padding()
                    }
                } else {
                    Text("Failed to fetch reviews")
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            viewModel.fetchReviews(for: storeId)
        }
    }
}

class TestViewModel: ObservableObject {
    @Published var reviews: StoreReview?
    @Published var isLoading = false
    
    func fetchReviews(for storeId: Int) {
        isLoading = true
        
        let url = URL(string: "http://3.34.33.15:8080/storeReview/storeId/\(storeId)")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            defer { self.isLoading = false }
            
            if let error = error {
                print("Failed to fetch reviews: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(StoreReview.self, from: data)
                    DispatchQueue.main.async {
                        self.reviews = decodedData
                    }
                } catch {
                    print("Failed to decode reviews: \(error)")
                }
            }
        }.resume()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(storeId: 9)
    }
}
