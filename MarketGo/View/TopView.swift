//
//  TopView.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import SwiftUI

struct TobView: View {
    var body: some View {
        HStack {
            MarketChoicePickerView()
//            Text("흑석시장")
//                .font(.headline)
            Spacer()
            
            NavigationLink{
                CartView()
            } label: {
                Image(systemName: "cart")
                    .padding(.horizontal)
                    .imageScale(.large)
            }
            ProfileImageView()
                
        }
        .padding()
        
        

    }
}

struct TobView_Previews: PreviewProvider {
    static var previews: some View {
        TobView()
    }
}
