import SwiftUI

struct MarketReviewView: View {
    @StateObject private var viewModel = MarketReviewViewModel()
    @EnvironmentObject var marketModel: MarketModel
    @State private var isWritingReview = false

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
            
            Button(action: {
                isWritingReview = true
            }, label: {
                Text("\(marketModel.currentMarket?.marketName ?? "") 리뷰 작성")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(30)
                    
            })
            .padding([.leading, .bottom, .trailing],10)
            
        }
        .sheet(isPresented: $isWritingReview, content: {
            // Present the view for writing a review
            MarketReviewPostView()
        })
        .onAppear {
            viewModel.fetchMarketReviews(for: marketModel.currentMarket?.marketID ?? 0)
        }
    }
}


struct MarketReviewRow: View {
    let review: MarketReviewElement
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("\(review.ratings ?? 0)점")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(5)
//                    .padding(.horizontal, 5)
//                    .padding(.vertical, 5)
                    .background(Color.yellow)
                    .cornerRadius(10)
                
                HStack(spacing: 0) {
                    ForEach(0..<5) { index in
                        Image(systemName: "star.fill")
                            .foregroundColor(index < (review.ratings ?? 0) ? .yellow : .gray)
                    }
                }
                .padding(.leading, 5)
                .padding(.trailing,2)
                Text(review.mrMemberID?.memberName ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.leading,5)
            
            Text(review.reviewContent ?? "")
                .font(.body)
                .padding(.leading,5)
                //.padding(.horizontal, 1)
                //.padding(.vertical, 7)
            
            VStack(alignment: .leading) {
                RemoteImage2(url: URL(string: review.marketReviewFile?.uploadFileURL ?? ""))
                           // .frame(width: 100, height: 100)
                }
            .padding(.leading,5)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2, y: 1)
    }
}


