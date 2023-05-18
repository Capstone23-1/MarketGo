//
//  StoreReviewListView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/04.
//

import SwiftUI

struct StoreReviewListView: View {
    let store: StoreElement
    @StateObject private var viewModel = TestViewModel()
    
    var body: some View {
        VStack {
            Text("\(store.storeName ?? "") Review")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                LazyVStack {
                    if let reviews = viewModel.reviews {
                        ForEach(reviews) { review in
                            ReviewRow(review: review)
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
            }
            
            Text(review.reviewContent ?? "")
                .font(.body)
                .padding(.horizontal, 1)
                .padding(.vertical, 7)
            
            VStack(alignment: .leading) {
                
                GoodsImage(url: URL(string: review.storeReviewFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo"))
                }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2, y: 1)
    }
}
