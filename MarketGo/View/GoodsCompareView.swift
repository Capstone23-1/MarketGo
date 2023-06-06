//
//  GoodsCompareView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/06/06.
//

import SwiftUI

struct GoodsCompareView: View {
    @StateObject var viewModel = GoodsViewModel()
    let goodsName: String
    let marketId: Int
    
    var body: some View {
        VStack {
            Text("Goods Name: \(goodsName)")
                .font(.headline)
                .padding()
            
            Text("Market ID: \(marketId)")
                .font(.subheadline)
                .padding()
            
            List(viewModel.goods, id: \.id) { goods in
                VStack(alignment: .leading) {
                    Text(goods.goodsName ?? "")
                        .font(.headline)
                    Text("Price: \(goods.goodsPrice ?? 0)")
                        .font(.subheadline)
                    Text("Market: \(goods.goodsMarket?.marketName ?? "")")
                        .font(.subheadline)
                }
            }
        }
        .onAppear {
            viewModel.fetchGoodsCompare(goodsName: goodsName, marketId: marketId)
        }
    }
}

struct GoodsCompareView_Previews: PreviewProvider {
    static var previews: some View {
        GoodsCompareView(goodsName: "등심", marketId: 18)
    }
}
