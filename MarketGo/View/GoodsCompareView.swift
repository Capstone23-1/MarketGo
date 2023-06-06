//
//  GoodsCompareView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/06/06.
//

import SwiftUI

struct GoodsCompareView: View {
    @StateObject var viewModel = GoodsViewModel()
    @EnvironmentObject var marketModel: MarketModel
    
    let goodsName: String
    let marketId: Int
    
    var body: some View {
        VStack {
            Text("시장 내 가격비교")
                .font(.headline)
                .padding()
            
            List(viewModel.goods, id: \.id) { goods in
                
                HStack {
                    HStack {
                        if let fileData = goods.goodsFile, let uploadFileURL = fileData.uploadFileURL, let url = URL(string: uploadFileURL) {
                            URLImage(url: url)
                        } else {
                            Text("Loading...")
                        }

                    }
                    Spacer()

                    VStack(alignment: .leading, spacing: 10) {
                        Text(goods.goodsName ?? "")
                            .font(.headline)
                            .foregroundColor(.black)

                        Text("가격 : \(goods.goodsPrice ?? 0)")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Text("\(goods.goodsStore?.storeName ?? "")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            
                    }

                    Spacer()

                    HStack {
                        Text("\(goods.goodsMarket?.marketName ?? "")")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                }
                .padding()
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
