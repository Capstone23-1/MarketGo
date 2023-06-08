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
    var storeName: String

    var body: some View {
        VStack {
            Text("\(storeName) 메뉴판")
                .font(.title3)
                .fontWeight(.bold)
                .padding()
            // Menu Board
            if !goodsViewModel.goods.isEmpty{
                List(goodsViewModel.goods) { good in
                    if good.isAvail == 1 { // Check if isAvail is 1
                        NavigationLink(destination: FoodItemDetailView(goods: good)) {
                            MenuItemRow(goods: good, storeID: good.goodsStore?.storeID ?? 0)
                                .foregroundColor(.black)
                        }
                    }
                }
            } else {
                Text("등록된 메뉴 없음")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            goodsViewModel.fetchGoods(forGoodsStoreID: storeID)
        }
    }
}

