//
//  NaverView.swift
//  MarketGo
//
//  Created by ram on 2023/06/22.
//

import Foundation
import SwiftUI

struct NaverView: View {
    @StateObject private var viewModel = NaverViewModel()
    
    var body: some View {
        VStack {
            Text("네이버 결과")
                .font(.headline)
                .padding()
            
            Image(uiImage: viewModel.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .padding()
            
            Button(action: {
                viewModel.changeImageToText()
            }, label: {
                Text("변환")
                    .foregroundColor(.blue)
            })
            .padding()
            
            Text(viewModel.stringResult)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
