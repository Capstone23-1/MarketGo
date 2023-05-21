import SwiftUI
import Alamofire

struct MarketReviewSubmissionView: View {
    @State private var marketId: Int = 0
    @State private var memberId: Int = 0
    @State private var ratings: Double = 0.0
    @State private var reviewContent: String = ""
    @State private var marketReviewFile: Int = 0
    
    @StateObject private var viewModel = MarketReviewPostViewModel()
    
    var body: some View {
        VStack {
            TextField("Market ID", value: $marketId, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Member ID", value: $memberId, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Ratings", value: $ratings, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Review Content", text: $reviewContent)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Market Review File ID", value: $marketReviewFile, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Submit") {
                viewModel.submitMarketReview(marketId: marketId, memberId: memberId, ratings: ratings, reviewContent: reviewContent, marketReviewFile: marketReviewFile)
            }
            .padding()
            .disabled(viewModel.isLoading)
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        }
        .padding()
        .onAppear {
            viewModel.reset()
        }
    }
}

struct MarketReviewSubmissionView_Previews: PreviewProvider {
    static var previews: some View {
        MarketReviewSubmissionView()
    }
}

class MarketReviewPostViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var showingAlert = false
    @Published var errorMessage = ""
    
    func submitMarketReview(marketId: Int, memberId: Int, ratings: Double, reviewContent: String, marketReviewFile: Int) {
        isLoading = true
        
        let parameters: [String: Any] = [
            "marketId": marketId,
            "memberId": memberId,
            "ratings": ratings,
            "reviewContent": reviewContent,
            "marketReviewFile": marketReviewFile
        ]
        
        let url = URL(string: "http://3.34.33.15:8080/marketReview")!
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            self.isLoading = false
            
            switch response.result {
            case .success:
                // Successful submission, do any additional handling if needed
                break
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
    }
    
    func reset() {
        isLoading = false
        showingAlert = false
        errorMessage = ""
    }
}
