//
//  ShopView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/04.
//  mainView에서 장보기 탭


import SwiftUI

struct ShopView: View {
    @ObservedObject var storeModel = StoreViewModel()
    @ObservedObject var goodsModel = GoodsViewModel()
    
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var marketModel: MarketModel

    @State var marketId: Int? = 0

    // Check if the value is not nil before accessing its properties

    
    @State private var searchText = ""
    @State private var placeHolder: String = "시장 또는 물품 검색"
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var topStores: [StoreElement] {
        Array(storeModel.stores.sorted { $0.storeRatings ?? 0 > $1.storeRatings ?? 0 }.prefix(3))
    }
    
    var filteredStores: [StoreElement] {
        if searchText.isEmpty {
            return topStores
        } else {
            return topStores.filter { $0.storeName?.contains(searchText) ?? false }
        }
    }
    
    var body: some View {
        NavigationView { // NavigationView 추가
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading){
                    
                    
                    SearchBar(searchText: $searchText, placeHolder: $placeHolder)
                    Spacer()
                    
                    ScrollView{
                        Text("\(marketModel.currentMarket?.marketID ?? 0)")
                        
                        VStack { // ScrollView 추가
                            Spacer()
                            
                            HStack{
                                
                                Text("가게 랭킹 top3 (리뷰 많은 순) ")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                Spacer()
                                NavigationLink(destination: StoreListView()){
                                    Text("가게 더보기 > ")
                                        .foregroundColor(.black)
                                        .padding(.horizontal)
                                }
                            }

                            
                            LazyVStack { // LazyVStack 사용
                                ForEach(filteredStores.indices, id: \.self) { index in
                                    let store = filteredStores[index]
                                    NavigationLink(destination: StoreView(store: store)){

                                        HStack {
                                            
                                            VStack {
                                                if let fileData = store.storeFile {
                                                    URLImage(url: URL(string: fileData.uploadFileURL ?? "")) // Pass the URL directly
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
                                                Text(String(format: "%.1f", store.storeRatings ?? 0.0))
                                                    .font(.subheadline)
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        .padding() 
                                        
                                    }
                                }
                                
                            }
                            
                        }.onAppear {
                            storeModel.fetchStores(forMarketId: marketModel.currentMarket?.marketID ?? 0)
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("상품 >")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                Spacer()
                                NavigationLink(destination: FoodItemListView(marketId: marketModel.currentMarket?.marketID ?? 0)) {
                                    Text("상품 더보기 >")
                                        .foregroundColor(.black)
                                        .padding(.horizontal)
                                }
                            }
                            
                            LazyVGrid(columns: layout) {
                                ForEach(goodsModel.goods) { item in
                                    NavigationLink(destination: FoodItemDetailView(goods: item)) {
                                        FoodItemCell(goods: item)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .padding([.top, .leading, .trailing], 16.0)
                        }
                        .onAppear {
                            goodsModel.fetchGoods(forStoreMarketID: marketModel.currentMarket?.marketID ?? 0)
                        }
                        
                    }
                    
                    
                    
                }
                .navigationBarHidden(true) // 네비게이션 바 숨김
                
            }
            
        }
    }
    
    
    struct ShopView_Previews: PreviewProvider {
        static var previews: some View {
            ShopView()
        }
    }
    
}
