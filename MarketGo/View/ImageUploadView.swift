import SwiftUI
import Alamofire
import UIKit

struct ImageUploadView: View {
    @State var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var category: String
    @State private var showDefaultImagePicker: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var showCamera: Bool = false
    
    let imageUploader = ImageUploader()
    @Binding var selectedImage: UIImage? // 선택된 이미지를 저장할 변수
    
    @Binding var newImage: FileInfo
    let imageSize = 100.0
    
    var body: some View {
        
        HStack(alignment:.center){
            
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
                    
                    // ImageUploadView
                    Button("기본 이미지") {
                        showDefaultImagePicker = true
                    }
                    .onTapGesture {
                        showDefaultImagePicker = true
                        showImagePicker = false
                    }
                    .sheet(isPresented: $showDefaultImagePicker) {
                        DefaultImageView(selectedImage: self.$selectedImage)
                    }
                    .padding(.horizontal)
                    
                    Button("앨범 선택") {
                        showImagePicker = true
                        sourceType = .photoLibrary
                    }
                    .onTapGesture {
                        showDefaultImagePicker = false
                        showImagePicker = true
                    }
                    .sheet(isPresented: $showImagePicker, onDismiss: {
                        showDefaultImagePicker = false
                        showImagePicker = false
                    }) {
                        ImagePickerModel(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                    }
                    .padding(.horizontal)
                    
                    // 카메라 촬영 버튼 추가
                    Button("카메라 촬영") {
                        showImagePicker = true
                        sourceType = .camera
                    }
                    .onTapGesture {
                        showDefaultImagePicker = false
                        showImagePicker = true
                    }
                    .sheet(isPresented: $showImagePicker, onDismiss: {
                        showDefaultImagePicker = false
                        showImagePicker = false
                    }) {
                        ImagePickerModel(selectedImage: self.$selectedImage, sourceType: .camera)
                    }
                    .padding(.horizontal)
                    
                }
                
            }
            
            
        }
    }
}
