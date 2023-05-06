//
//  MarketChoicePickerView.swift
//  MarketGo
//
//  Created by ram on 2023/04/05.
//

import SwiftUI

struct MarketChoicePickerView: View {
    @State private var selectedMarket = 0
    let markets = ["흑석시장", "상도시장", "광장시장", "시장선택"]

    var body: some View {
        Picker(selection: $selectedMarket, label: Text("")) {
            ForEach(0 ..< markets.count) {
                Text(self.markets[$0]).tag($0)
            }
        }
        .pickerStyle(.menu)
        Spacer()
    }

}

struct MarketChoicePickerView_Previews: PreviewProvider {
    static var previews: some View {
        MarketChoicePickerView()
    }
}
