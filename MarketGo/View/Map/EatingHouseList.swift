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
    @ObservedObject var vm:MarketSearchViewModel
    
    var body: some View {
        List(selection: $vm.selectedID) {
            ForEach(data) { market in
                HStack {
                    Text("\(market.placeName)   \(market.distance)m")
                        .tag(market.id)  // 각 항목에 ID 태그를 추가합니다.
                        .onTapGesture {
                            selected = market
                            vm.selectedID = market.id
                        }
                   
                }
            }
        }


    }
}
