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
    
    var body: some View {
        VStack {
            Text("시장 내 가격비교")
                .font(.headline)
                .padding()
            
            if viewModel.goods.isEmpty {
                Text("비교할 수 있는 상품이 없습니다.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(viewModel.goods, id: \.id) { goods in
                    
                    HStack {
                        HStack {
                            if let fileData = goods.goodsFile, let uploadFileURL = fileData.uploadFileURL, let url = URL(string: uploadFileURL) {
                                GoodsImage(url: url)
                                    .frame(width: 60, height: 60)
                            } else {
                                Text("Loading...")
                            }
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 10) {
                            Text(goods.goodsName ?? "")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("가격: \(goods.goodsPrice ?? 0)")
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
        }
        .onAppear {
            viewModel.fetchGoodsCompare(goodsName: goodsName, marketId: marketModel.currentMarket?.marketID ?? 0)
        }
    }
}

