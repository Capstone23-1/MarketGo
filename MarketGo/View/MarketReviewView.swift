import SwiftUI

struct MarketReviewView: View {
    @StateObject private var viewModel = MarketReviewViewModel()
    @EnvironmentObject var marketModel: MarketModel

    var body: some View {
        VStack {
            
            ScrollView {
                LazyVStack {
                    if let reviews = viewModel.marketReviews {
                        ForEach(reviews) { review in
                            MarketReviewRow(review: review)
                        }
                    } else {
                        ProgressView()
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchMarketReviews(for: marketModel.currentMarket?.marketID ?? 0)
        }
    }
}

import SwiftUI


struct MarketReviewRow: View {
    let review: MarketReviewElement
    @State private var image: UIImage? = nil
    
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
                
                Text(review.mrMemberID?.memberName ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            Text(review.reviewContent ?? "")
                .font(.body)
                .padding(.horizontal, 1)
                .padding(.vertical, 7)
            
            VStack(alignment: .leading) {
                RemoteImage2(url: URL(string: review.marketReviewFile?.uploadFileURL ?? ""))
                           // .frame(width: 100, height: 100)
                }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2, y: 1)
    }
}
