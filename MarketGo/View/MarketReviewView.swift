import SwiftUI

struct MarketReviewView: View {
    @StateObject private var viewModel = MarketReviewViewModel()
    @EnvironmentObject var marketModel: MarketModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let marketReviews = viewModel.marketReviews {
                ForEach(marketReviews, id: \.marketReviewID) { review in
                    Text("")
                }
            } else {
                Text("No reviews found")
            }
        }
        .onAppear {
            viewModel.fetchMarketReviews(for: marketModel.currentMarket?.marketID ?? 0)
        }
    }
}
