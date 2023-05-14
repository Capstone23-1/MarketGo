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

    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    TextField("시장 이름으로 검색", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Image(systemName: "magnifyingglass")
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)

                Divider()

                LazyVStack {
                    ForEach(storeModel.stores.sorted { $0.storeRatings ?? 0 > $1.storeRatings ?? 0 }.filter {
                        searchText.isEmpty ? true : $0.storeName?.contains(searchText) ?? false
                    }) { store in
                        NavigationLink(destination: StoreView(store: store)) {
                            HStack {
                                if let storeFile = store.storeFile,
                                   let uploadFileURL = storeFile.uploadFileURL,
                                   let url = URL(string: uploadFileURL) {
                                    URLImage(url: url)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(1)
                                } else {
                                    Text("Loading...")
                                }

                                VStack(alignment: .leading, spacing: 10) {
                                    Text(store.storeName ?? "")
                                        .font(.headline)
                                        .foregroundColor(.black)

                                    Text("작성된 리뷰 \(store.storeRatings ?? 0)개 > ")
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

                            // Display goods information for the store
                            VStack(alignment: .leading) {
                                if let storeMarketID = store.storeMarketID {
                                    Text("상품 정보:")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .padding(.top)
                                    ForEach(goodsViewModel.goods.filter { $0.goodsStore?.storeID == storeMarketID.marketID }, id: \.id) { goods in
                                        Text(goods.goodsName ?? "")
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                storeModel.fetchStores(marketId: 17) // Provide the desired marketId here
                goodsViewModel.fetchGoods(forStoreMarketID: 17) // Provide the desired marketId here
            }
        }
    }
}
