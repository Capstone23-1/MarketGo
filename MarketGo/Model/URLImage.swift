//
//  URLImage.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/15.
//

import SwiftUI

struct URLImage: View {
    let url: URL?
    let placeholder: Image

    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let url = url, let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(1)
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(1)
            }
        }
    }
}
