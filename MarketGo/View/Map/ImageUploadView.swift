import SwiftUI
import Alamofire
import UIKit

struct ImageUploadView: View {
    @State var showImagePicker: Bool = false
    @State var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var category: String
    @Binding var did: Int
    var id: Binding<String> {
        Binding<String>(
            get: { String(did) },
            set: { did = Int($0) ?? 0 }
        )
    }
    let imageUploader = ImageUploader()
    @Binding var selectedImage: UIImage? // 선택된 이미지를 저장할 변수
    
    @Binding var newImage: FileInfo
    let imageSize = 100.0
    
    var body: some View {
        
        VStack {
            // 이미지가 선택되었을 경우 이미지 표시
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(Circle())
                    .padding(.top)
            } else {
                // 이미지가 선택되지 않았을 경우 기본 이미지 표시
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(Circle())
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
            
        }.padding()
    }
}





