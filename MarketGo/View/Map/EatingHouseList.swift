//
//  EatingHouseList.swift
//  MarketGo
//
//  Created by ram on 2023/05/30.
//


import SwiftUI
struct EatingHouseList: View {
    var data: [Document]
    @Binding var selected: Document?
    
    @State private var isLoading = false // indicator 추가
    
    @State var selectedMarket: MarketOne?
    @EnvironmentObject var marketModel: MarketModel
    @EnvironmentObject var userModel: UserModel
    @ObservedObject var vm: MarketSearchViewModel
    
    var sortedData: [Document] {
        data.sorted { $0.distance < $1.distance }
    }
    
    var body: some View {
        List(selection: $vm.selectedID) {
            ForEach(sortedData) { market in
                HStack {
                    Text("\(market.placeName)   \(market.distance)m")
                        .tag(market.id)  // 각 항목에 ID 태그를 추가합니다.
                        .foregroundColor(vm.selectedID == market.id ? .blue : .black)  // 선택된 아이템을 블루로 표시
                        .onTapGesture {
                            selected = market
                            vm.selectedID = market.id
                        }
                }
            }
        }
    }
}
