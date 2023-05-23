//
//  FoodItemListView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import SwiftUI

struct FoodItemListView: View {
    @StateObject private var goodsViewModel = GoodsViewModel()
    @State private var searchText = ""
    @State private var placeHolder: String = "시장 또는 물품 검색"
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var filteredGoods: [GoodsOne] {
        if searchText.isEmpty {
            return goodsViewModel.goods
        } else {
            return goodsViewModel.goods.filter { $0.goodsName?.localizedCaseInsensitiveContains(searchText) == true }
        }
    }
    
    var body: some View {
        
        VStack {
            GoodsSearchBar(text: $searchText, placeholder: placeHolder)
                .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(filteredGoods) { goods in
                        NavigationLink(destination: FoodItemDetailView(goods: goods)) {
                            VStack {
                                FoodItemCell(goods: goods)
                            }
                        }
                    }
                }
                .padding([.top, .leading, .trailing], 16.0)
            }
        }
        .foregroundColor(.black)
        .onAppear {
            goodsViewModel.fetchGoods(forStoreMarketID: marketId)
        }
    }
    
    let marketId: Int
    
    init(marketId: Int) {
        self.marketId = marketId
    }
}

struct GoodsSearchBar: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

