import SwiftUI
import Alamofire
import UIKit

struct ImageUploadView: View {
    @State var image: UIImage?
    
    @Binding var category: String
    @State private var showDefaultImagePicker: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var showCameraPicker: Bool = false
    
    let imageUploader = ImageUploader()
    @Binding var selectedImage: UIImage? // 선택된 이미지를 저장할 변수
    
    @Binding var newImage: FileInfo
    let imageSize = 100.0
    
    var body: some View {
        
        VStack(alignment:.center) {
            // 이미지가 선택되었을 경우 이미지 표시
            HStack{
                Spacer()
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imageSize, height: imageSize)
                        .padding(.top)
                } else {
                    // 이미지가 선택되지 않았을 경우 기본 이미지 표시
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageSize, height: imageSize)
                        .padding(.top)
                }
                Spacer()
            }
            HStack{
                
                // 기본 이미지 선택
                NavigationLink("기본", destination: DefaultImageView(selectedImage: self.$selectedImage), isActive: $showDefaultImagePicker)
                    .padding(.horizontal)
                    .onTapGesture {
                        showDefaultImagePicker = true
                    }
                
                // 앨범에서 이미지 선택
                NavigationLink("앨범", destination: ImagePickerModel(selectedImage: self.$selectedImage, sourceType: .photoLibrary), isActive: $showImagePicker)
                    .padding(.horizontal)
                    .onTapGesture {
                        showImagePicker = true
                    }
                
                // 카메라 촬영
                NavigationLink("카메라", destination: ImagePickerModel(selectedImage: self.$selectedImage, sourceType: .camera), isActive: $showCameraPicker)
                    .padding(.horizontal)
                    .onTapGesture {
                        showCameraPicker = true
                    }
                
            }
        }
        
    }
}
