//
//  MarketInfoView.swift
//  MarketGo
//
//  Created by ram on 2023/05/06.
//

import SwiftUI
import Alamofire

struct MarketInfoView: View {
    @State private var marketData: MarketOne?

    var body: some View {
        VStack {
            if let marketData = marketData {
                // 가져온 데이터를 사용하여 UI 구성
                Text("\(marketData[0].marketName)")
                Text("\(marketData[0].marketInfo)")
                Text("\(marketData[0].marketRatings)")
                Text("\(marketData[0].marketAddress1)")
            } else {
                // 데이터를 가져오는 중인 경우 로딩 스피너 표시
                ProgressView()
            }
        }
        .onAppear {
            // API 요청을 수행
                        fetchData(with: "흑석시장") { result in
                            switch result {
                            case .success(let data):
                                self.marketData = data
                            case .failure(let error):
                                print(error)
                            }
                        }
        }
    }
    
}
