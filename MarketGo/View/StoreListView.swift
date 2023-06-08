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
    @EnvironmentObject var userModel:UserModel
    @State var isLoading = false

    var body: some View {
        ZStack{
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
            if isLoading {
                
                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .frame(width: 100, height: 100)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                
                
            }
        }
        .onAppear {
            
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline:.now()+0.5) {
                storeModel.fetchStores(forMarketId: userModel.currentUser?.interestMarket?.marketID ?? (marketModel.currentMarket?.marketID) ?? 0) // Provide the desired marketId here
                goodsViewModel.fetchGoods(forStoreMarketID: userModel.currentUser?.interestMarket?.marketID ?? (marketModel.currentMarket?.marketID) ?? 0) // Provide the desired marketId here
                isLoading = false
            }
           
        }
    }
}
