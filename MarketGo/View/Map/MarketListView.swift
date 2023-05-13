//
//  MarketListView.swift
//  MarketGo
//
//  Created by ram on 2023/05/06.
//

import Foundation
import SwiftUI

struct MarketListView: View {
    @Binding var marketData: MarketOne?
    
    var body: some View {
        NavigationView {
            List {
                if let marketData = marketData {
                    Section(header: Text("데이터 기준 일자: \(convertDate(from: marketData.updateTime!))")) {
                        Text("시장 이름: \(marketData.marketName ?? "")")
                        Text("주소: \(marketData.marketAddress1 ?? "") \(marketData.marketAddress2 ?? "")")
                        Text("평점: \(String(format:"%.1f",marketData.marketRatings ?? 0.0)) ")
                        Text("상세 정보: \(marketData.marketInfo ?? "")")
                        Text("주차장: \(marketData.parking ?? "")")
                        Text("화장실: \(marketData.toilet ?? "")")
                        Text("전화번호: \(marketData.marketPhonenum ?? "")")
                        Text("지역화페: \(marketData.marketGiftcard!)")
                        
                    }
                } else {
                    Text("데이터를 불러오는 데 실패했습니다.")
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
    
    func convertDate(from string: String) -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            if let date = inputFormatter.date(from: string) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "yyyy.MM.dd"
                return outputFormatter.string(from: date)
            } else {
                return "Invalid date"
            }
        }
}

