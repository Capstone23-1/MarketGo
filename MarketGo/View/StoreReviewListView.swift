//
//  StoreReviewListView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/04.
//

import SwiftUI

struct StoreReviewListView: View {
    let store: Store = Store.stores[0]
    @State private var reviews: [Review] = Review.reviews
    @State private var showMoreReviews = false
    
    var body: some View {
        VStack {
            Text(store.store_name)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                LazyVStack {
                    ForEach(reviews) { review in
                        ReviewRow(review: review)
                            .frame(height: fixedHeight)
                    }
                }
            }
            .padding()
            
            
        }
    }
    
    let fixedHeight: CGFloat = 120 // 리뷰 뷰의 고정 높이
}

struct ReviewRow: View {
    let review: Review
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(review.rating)점")
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.yellow)
                    .cornerRadius(10)
                
                HStack(spacing: 0) {
                                    ForEach(0..<5) { index in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(index < review.rating ? .yellow : .gray)
                                    }
                                }
                               
                Text(review.author)
                    .font(.headline)
                    .fontWeight(.bold)
                
            }
            Text(review.text)
                .font(.body)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2, y: 1)

    }
}


struct StoreReviewListView_Previews: PreviewProvider {
    
    static var previews: some View {
        StoreReviewListView()
    }
}
