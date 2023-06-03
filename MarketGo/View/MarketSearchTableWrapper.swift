//
//  MarketTableWrapper.swift
//  MarketGo
//
//  Created by ram on 2023/05/11.
//
import SwiftUI
import Alamofire
struct MarketSearchTableWrapper: View {
    var data: [Document]
    @Binding var selected: Document?
    
    @Binding var isLoading :Bool
    @State private var isLinkActive = false //버튼위해서사용
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
                    Spacer()
                    Button(action: {
                        userModel.NMap = market
                        isLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            vm.fetchMarketData(marketName: market.placeName)
                            selected = market
                            isLinkActive = true
                            isLoading = false
                        }
                    }) {
                        Image(systemName: "arrowtriangle.forward")
                            .foregroundColor(.black)
                    }
                    .background(
                        NavigationLink(destination: MarketInfoView(selectedMarket: $vm.selectedMarket), isActive: $isLinkActive) {
                            EmptyView()
                        }
                            .hidden()
                    )
                }
            }
        }
        
        
    }
}
