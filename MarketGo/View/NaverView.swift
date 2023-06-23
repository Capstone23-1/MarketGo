//
//  NaverView.swift
//  MarketGo
//
//  Created by ram on 2023/06/22.
//

import Foundation
import SwiftUI

struct NaverView: View {
    @ObservedObject public var nvm : NaverViewModel
    @Binding var stringResult:String
    
    var body: some View {
        VStack {
            Text("네이버 결과")
                .font(.headline)
                .padding()
            
      
            
            Text(nvm.stringResult)
                .multilineTextAlignment(.center)
                .padding()
           
        }
    }
}
