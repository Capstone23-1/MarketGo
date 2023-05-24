//
//  MenuView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/15.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject private var goodsViewModel = GoodsViewModel2()
    let storeID: Int // Store ID

    var body: some View {
        VStack {
            // Menu Board
            if !goodsViewModel.goods.isEmpty {
                List(goodsViewModel.goods) { good in
                    NavigationLink(destination: FoodItemDetailView(goods: good)) {
                        MenuItemRow(goods: good, storeID: good.goodsStore?.storeID ?? 0)
                            .foregroundColor(.black)
                    }
                    
                }
            } else {
                Text("No menu items available")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            goodsViewModel.fetchGoods(forGoodsStoreID: storeID)
        }
    }
}
