//
//  FoodItemCell.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/04.
//

import SwiftUI

import SwiftUI

struct FoodItemCell: View {
    var goods: GoodsOne
    
    var body: some View {
        VStack {
            GoodsImage(url: URL(string: goods.goodsFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo"))
                .frame(width: 110, height: 110)
            
            Text(goods.goodsName ?? "")
                .font(.system(size: 16, weight: .bold))
            Text(goods.goodsStore?.storeName ?? "").font(.system(size: 11, weight: .bold))
            Text("가격 : \(goods.goodsPrice ?? 0)원").font(.system(size: 11))
            Spacer()
        }
    }
}
