//
//  MarketOtherTableWrapper.swift
//  MarketGo
//
//  Created by ram on 2023/05/30.
//
import SwiftUI
import Alamofire

struct MarketOtherTableWrapper: View {
    var data: [MarketOne]
//    @Binding var selected: MarketOne?
    var didSelectRowAt: ((Document) -> Void)? //Document -> MarketOne?
    @State private var isLoading = false // indicator 추가
    @State private var isLinkActive = false
    @State var selectedMarket: MarketOne?
    @EnvironmentObject var marketModel: MarketModel
    
    var body: some View {
        List(data,id: \.marketName) { market in
            HStack {
                Text(market.marketName!)
                    .onTapGesture {
                        selectedMarket = market
//                        didSelectRowAt?(market)
                    }
                Spacer()
                Button(action: {
                    
                    selectedMarket = market
                    
                    isLinkActive = true
                }) {
                    Image(systemName: "arrowtriangle.forward")
                        .foregroundColor(.black)
                }
                .background(
                    NavigationLink(destination: MarketInfoView( selectedMarket: $selectedMarket), isActive: $isLinkActive) {
                        EmptyView()
                    }
                        .hidden()
                )
            }
        }
    }
    
    
}
