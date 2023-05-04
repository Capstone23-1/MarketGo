//
//  MarketInfoView.swift
//  MarketGo
//
//  Created by ram on 2023/05/02.
//

import Foundation
import SwiftUI

struct MarketInfoView: View {
    @Binding var selectedMarket: Document?
    
    var body: some View {
        if let market = selectedMarket {
            VStack {
                Text("Selected Market: \(market.placeName)")
                Text("Address: \(market.roadAddressName)")
                Text("Phone: \(market.phone)")
            }
        } else {
            Text("No market selected")
        }
    }
}

