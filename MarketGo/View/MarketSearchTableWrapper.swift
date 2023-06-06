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
    
    var didSelectRowAt: ((Document) -> Void)?
    @State private var isLoading = false // indicator 추가
    @State private var isLinkActive = false
    @State var selectedMarket: MarketOne?
    @EnvironmentObject var marketModel: MarketModel
    @StateObject var vm = MarketSearchViewModel()
    
    var body: some View {
        List(data,selection: $vm.selectedID) { market in
            HStack {
                Text("\(market.placeName)   \(market.distance)m")
                    .onTapGesture {
                        selected = market
                        vm.selectedID = market.id
//                        didSelectRowAt?(selected!)
                    }
                    
                Spacer()
                Button(action: {
                    
                    vm.fetchMarketData(marketName: market.placeName)
                    selected = market
                    
                    isLinkActive = true
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
