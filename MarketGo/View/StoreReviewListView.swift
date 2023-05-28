//
//  StoreReviewListView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/04.
//

import SwiftUI
import Alamofire

struct StoreReviewListView: View {
    let store: StoreElement
    @StateObject private var viewModel = TestViewModel()
    
    var body: some View {
        VStack {
            Text("\(store.storeName ?? "") Review")
                .font(.title3)
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
                RemoteImage(url: URL(string: review.storeReviewFile?.uploadFileURL ?? ""))
                            .frame(width: 80, height: 80)
                }
        }
        .frame(maxWidth: .infinity)
        .padding()
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2, y: 1)
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
