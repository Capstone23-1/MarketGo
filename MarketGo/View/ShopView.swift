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
    
    @EnvironmentObject var cartModel: CartModel
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var marketModel: MarketModel

    @State private var searchText = ""
    @State private var placeHolder: String = "시장 또는 물품 검색"
    @State var isLoading = false
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var topStores: [StoreElement] {
        Array(storeModel.stores.sorted { $0.reviewCount ?? 0 > $1.reviewCount ?? 0 }.prefix(3))
    }
    
    var filteredStores: [StoreElement] {
        if searchText.isEmpty {
            return topStores
        } else {
            return topStores.filter { $0.storeName?.contains(searchText) ?? false }
        }
    }
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading){
                    
                    ScrollView{
                        
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
                                                    RemoteImage(url: URL(string: fileData.uploadFileURL ?? ""))
                                                    
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
                            
                            Task {
                                isLoading = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    Task{
                                        storeModel.fetchStores(forMarketId: userModel.currentUser?.interestMarket?.marketID ?? 0)
                                        cartModel.fetchCart(forUserId: userModel.currentUser?.cartID?.cartID ?? 0)
                                        cartModel.updateCartItems()
                                        }
                                        
                                    isLoading = false
                                    }
                                    
                                }
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("상품")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                Spacer()
                                NavigationLink(destination: FoodItemListView(marketId: userModel.currentUser?.interestMarket?.marketID ?? 0)) {
                                    Text("상품 더보기 >")
                                        .foregroundColor(.black)
                                        .padding(.horizontal)
                                }
                            }
                            
                            
                            LazyVGrid(columns: layout) {
                                ForEach(goodsModel.goods.prefix(12)) { item in
                                    NavigationLink(destination: FoodItemDetailView(goods: item)) {
                                        FoodItemCell(goods: item)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .padding([.top, .leading, .trailing], 16.0)
                            
                        }
                        .onAppear {
                            Task {
                                isLoading = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    Task{
                                        goodsModel.fetchGoods(forStoreMarketID: userModel.currentUser?.interestMarket?.marketID ?? (marketModel.currentMarket?.marketID) ?? 0)
                                        }
                                        
                                    isLoading = false
                                    }
                                    
                                }
                                
                                
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
    }
    
    
    struct ShopView_Previews: PreviewProvider {
        static var previews: some View {
            ShopView()
        }
    }
    
}
