//
//  MarketTableWrapper.swift
//  MarketGo
//
//  Created by ram on 2023/05/11.
//

import SwiftUI
struct MarketTableWrapper: View {
    var data: [Document]
    @Binding var selected: Document?
    var didSelectRowAt: ((Document) -> Void)?
    @State private var isLoading = false // indicator 추가
    @State private var isLinkActive = false
    
    var body: some View {
        List(data) { market in
            HStack {
                Text("\(market.placeName)   \(market.distance)m")
                    .onTapGesture {
                        selected = market
                        didSelectRowAt?(market)
                    }
                Spacer()
                Button(action: {
                    selected = market
                    isLinkActive = true
                }) {
                    Image(systemName: "arrowtriangle.forward")
                        .foregroundColor(.black)
                }
                .background(
                    NavigationLink(destination: MarketInfoView(selected: $selected), isActive: $isLinkActive) {
                        EmptyView()
                    }
                        .hidden()
                )
            }
        }
    }
}

struct DetailView: View {
    var market: Document
    
    var body: some View {
        Text("\(market.placeName)")
            .navigationTitle("Detail")
    }
}
