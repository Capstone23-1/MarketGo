//
//  ReviewImageUploadView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/24.
//

import SwiftUI
import Alamofire
import UIKit

struct ReviewImageUploadView: View {
    @State var showImagePicker: Bool = false
    @State var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var category: String

    let imageUploader = ImageUploader()
    @Binding var selectedImage: UIImage? // Selected image variable
    @Binding var newImage: FileInfo
    let imageSize = 100.0

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center) {
                // Display the selected image if available
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageSize + 50, height: imageSize + 50)
                        
                        .padding(.top)
                }

                Button("이미지 선택") {
                    self.showImagePicker = true
                }
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    self.showImagePicker = false
                }) {
                    ImagePickerModel(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                }
            }
            .padding()
            Spacer()
        }
    }
}

