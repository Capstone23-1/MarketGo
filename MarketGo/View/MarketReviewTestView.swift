//
//  MarketReviewTestView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/21.
//

import SwiftUI

struct MarketReviewTestView: View {
    let marketId: Int
    @StateObject private var viewModel = MarketReviewViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let marketReviews = viewModel.marketReviews {
                ForEach(marketReviews, id: \.marketReviewID) { review in
                    Text(review.reviewContent ?? "")
                }
            } else {
                Text("No reviews found")
            }
        }
        .onAppear {
            viewModel.fetchMarketReviews(for: marketId)
        }
    }
}


struct MarketReviewTestView_Previews: PreviewProvider {
    static var previews: some View {
        MarketReviewTestView(marketId: 17)
    }
}
