//
//  MarketListView.swift
//  MarketGo
//
//  Created by ram on 2023/05/06.
//

import Foundation
import SwiftUI

struct MarketListView: View {
    @Binding var marketData: MarketOneElement?
    
    var body: some View {
        NavigationView {
            List {
                if let marketData = marketData {
                    Section(header: Text("데이터 기준 일자: 2022-07-06")) {
                        Text("시장 이름: \(marketData.marketName ?? "")")
                        Text("주소: \(marketData.marketAddress1 ?? "") \(marketData.marketAddress2 ?? "")")
//                        Text("지역: \(marketData.marketLocation ?? "")")
//                        Text("위도: \(marketData.marketLatitude ?? 0.0)")
//                        Text("경도: \(marketData.marketLongitude ?? 0.0)")
                        
                        Text("평점: \(String(format:"%.1f",marketData.marketRatings ?? 0.0)) ")
                        Text("상세 정보: \(marketData.marketInfo ?? "")")
                        Text("주차장: \(marketData.parking ?? "")")
                        Text("화장실: \(marketData.toilet ?? "")")
                        Text("전화번호: \(marketData.marketPhonenum ?? "")")
                        
                    }
                } else {
                    Text("데이터를 불러오는 데 실패했습니다.")
                }
            }
            .listStyle(GroupedListStyle())
            .onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        let jsonString = """
        {
            "marketId": 2,
            "marketName": "상도시장",
            "marketAddress1": "상도역",
            "marketAddress2": "",
            "marketLocation": "서울",
            "marketLatitude": 37.499677,
            "marketLongitude": 126.961537,
            "marketRatings": 3.8,
            "marketInfo": "규모가 큰 시장은 아니지만, 좋은 상품들이 풍성하게 있고 정이 넘치는 전통시장이다.",
            "parking": "O",
            "toilet": "O",
            "marketPhonenum": "02-824-3747",
            "marketGiftcard": "온누리상품권",
            "marketFile": null
        }
        """

        if let jsonData = jsonString.data(using: .utf8) {
            let decoder = JSONDecoder()
            do {
                marketData = try decoder.decode(MarketOneElement.self, from: jsonData)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
}

