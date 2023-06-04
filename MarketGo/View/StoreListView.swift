//
//  StoreListView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import SwiftUI

struct StoreListView: View {
    @StateObject var storeModel = StoreViewModel()
    @StateObject var goodsViewModel = GoodsViewModel()
    @State private var searchText = ""
    @EnvironmentObject var marketModel: MarketModel

    var body: some View {
        ScrollView {
            HStack {
                TextField("가게 이름으로 검색", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Image(systemName: "magnifyingglass")
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)

            Divider()

            LazyVStack {
                ForEach(storeModel.stores.sorted { $0.reviewCount ?? 0 > $1.reviewCount ?? 0 }.filter {
                    searchText.isEmpty ? true : $0.storeName?.contains(searchText) ?? false
                }) { store in
                    NavigationLink(destination: StoreView(store: store)) {
                        HStack {
                            HStack {
                                if let fileData = store.storeFile, let uploadFileURL = fileData.uploadFileURL, let url = URL(string: uploadFileURL) {
                                    URLImage(url: url)
                                } else {
                                    Text("Loading...")
                                }

                            }

                            VStack(alignment: .leading, spacing: 10) {
                                Text(store.storeName ?? "")
                                    .font(.headline)
                                    .foregroundColor(.black)

                                Text("작성된 리뷰 \(store.reviewCount ?? 0)개 > ")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }

                            Spacer()

                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text(String(format: "%.1f", store.storeRatings ?? 0))
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            storeModel.fetchStores(forMarketId: marketModel.currentMarket?.marketID ?? 0) // Provide the desired marketId here
            goodsViewModel.fetchGoods(forStoreMarketID: marketModel.currentMarket?.marketID ?? 0) // Provide the desired marketId here
        }
    }
}
