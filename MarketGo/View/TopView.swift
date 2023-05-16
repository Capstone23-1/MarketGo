//
//  TopView.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import SwiftUI

struct TobView: View {
    @EnvironmentObject var marketModel: MarketModel
    var body: some View {
        HStack {
//            MarketChoicePickerView()
            Text((marketModel.currentMarket?.marketName) ?? "N/A")
                .font(.headline)
//            Text( "\(marketModel.currentMarket?.marketID ?? 0)" )
//                .font(.headline)
            Spacer()
            
            NavigationLink{
                //CartView()
                Text("cart")
            } label: {
                Image(systemName: "cart")
                    .padding(.horizontal)
                    .imageScale(.large)
            }

                
        }
        .padding()
        
        

    }
}

struct TobView_Previews: PreviewProvider {
    static var previews: some View {
        TobView()
    }
}
