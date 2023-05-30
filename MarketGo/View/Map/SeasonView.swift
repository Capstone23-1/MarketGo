//
//  SeasonView.swift
//  MarketGo
//
//  Created by ram on 2023/05/30.
//

import SwiftUI

struct SeasonView: View {
    @State private var currentIndex = 0
    
    let images: [String] = [
        "5월제철음식",
        "6월제철음식",
        "7월제철음식",
        "8월제철음식",
        "9월제철음식",
        "10월제철음식",
        "11월제철음식",
        "12월제철음식",
        "1월제철음식",
    ]
    
    var body: some View {
        ZStack{
            VStack {
                Image(images[currentIndex])
                    .resizable()
                    .scaledToFit()
                    
                
                
                .padding()
            }
            HStack {
                Button(action: {
                    withAnimation {
                        currentIndex = (currentIndex - 1 + images.count) % images.count
                    }
                }) {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        currentIndex = (currentIndex + 1) % images.count
                    }
                }) {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
        }
        
    }
}
