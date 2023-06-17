//
//  DefaultImageView.swift
//  MarketGo
//
//  Created by ram on 2023/06/18.
//

import SwiftUI
import Alamofire
import UIKit

struct DefaultImageView: View {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    // Basic fruit images
    let fruitImages = ["apple", "banana", "broccoli", "carrot", "grape", "melon", "orange", "pineapple", "potato", "tomato", "watermelon","beef","pork","fish"]
        .compactMap { UIImage(named: $0) }
    
    var body: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(fruitImages, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            selectedImage = image
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
            .padding()
        }
    }
}
