//
//  ShopView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/04.
//  mainView에서 장보기 탭

import SwiftUI

struct ShopView: View {
    @State var stores: [Store] = Store.stores
    @State var foodlist : [FoodItem] = FoodItem.foodItems
    @State private var searchText = ""
    @State private var placeHolder: String = "시장 또는 물품 검색"
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

        var topStores: [Store] {
            Array(stores.sorted { $0.reviewCnt > $1.reviewCnt }.prefix(3))
        }

        var filteredStores: [Store] {
            if searchText.isEmpty {
                return topStores
            } else {
                return topStores.filter { $0.store_name.contains(searchText) }
            }
        }

        var body: some View {
            NavigationView { // NavigationView 추가
                VStack(alignment: .leading) {
                    SearchBar(searchText: $searchText, placeHolder: $placeHolder)
                    Spacer()
                    
                    ScrollView { // ScrollView 추가
                        Spacer()
                        Text("가게 랭킹 top3 (리뷰 많은 순) ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        LazyVStack { // LazyVStack 사용
                            ForEach(filteredStores, id: \.store_num) { store in
                                NavigationLink(destination: StoreView(store: store)){
                                    
                                    HStack {
                                        Image(store.store_image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 70, height: 70)
                                            .cornerRadius(10)

                                        VStack(alignment: .leading, spacing: 10) {
                                            Text(store.store_name)
                                                .font(.headline)
                                                .foregroundColor(.black)
                                            
                                            Text("작성된 리뷰 \(store.reviewCnt)개 > ")
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                        }
                                        Spacer()
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text(String(format: "%.1f", store.store_ratings))
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .padding() // 각 셀에 패딩 추가
                                    
                                }
                                
                            }
                        }
                        
                        
                        Text("상품 >")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        LazyVGrid(columns: layout){
                            ForEach(foodlist) { item in
                                FoodItemCell(fooditem: item)
                            }
                        }
                        .padding([.top, .leading, .trailing],16.0)
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



