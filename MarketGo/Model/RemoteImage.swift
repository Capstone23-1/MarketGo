//
//  RemoteImage.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/19.
//

import Foundation
import SwiftUI
import Alamofire

struct RemoteImage: View {
    let url: URL?
    let placeholder: Image
    
    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholder = placeholder
    }
    
    @State private var imageData: Data?
    
    var body: some View {
        Group {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                placeholder
            }
        }
        .onAppear {
            if let url = url {
                AF.request(url).responseData { response in
                    if case .success(let data) = response.result {
                        self.imageData = data
                    }
                }
            }
        }
    }
}
