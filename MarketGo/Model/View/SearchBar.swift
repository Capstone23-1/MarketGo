//
//  SearchBar.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var placeHolder: String
    
    var body: some View {
        
        HStack {
           TextField("\(placeHolder)", text: $searchText)
                .foregroundColor(.primary)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            Image(systemName: "magnifyingglass")
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
            
        }
    }
}

