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
    
    var body: some View {
        VStack {
            Text("네이버 결과")
                .font(.headline)
                .padding()
            
      
            Button(action: {
                nvm.changeImageToText()
            }, label: {
                Text("변환")
                    .foregroundColor(.blue)
            })
            .padding()
            
            Text(nvm.stringResult)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
