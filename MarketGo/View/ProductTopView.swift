//
//  ProductTopView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/05.
//

import SwiftUI

struct ProductTopView: View {
    
    
    var body: some View {
        
        HStack {

            Spacer()
            
//            NavigationLink{
//                CartView()
//            } label: {
//                Image(systemName: "cart")
//                    .padding(.horizontal)
//                    .imageScale(.large)
//            }
            
            NavigationLink(destination: CartView()) {
                Image(systemName: "cart")
                    .padding(.horizontal)
                    .imageScale(.large)
            }
//
        }
        .padding()
    }
}

struct ProductTopView_Previews: PreviewProvider {
    static var previews: some View {
        ProductTopView()
    }
}
