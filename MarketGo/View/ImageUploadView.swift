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


struct ImageUploadView: View {
    @State var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var category: String
    @State private var showDefaultImagePicker: Bool = false
    @State private var showImagePicker: Bool = false
    
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
                            .frame(width: imageSize+50, height: imageSize+50)
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
                }
                
            }
            
            
        }
    }
}
struct ImagePickerModel: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.sourceType = sourceType
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerModel
        
        init(_ parent: ImagePickerModel) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
struct ImageUploadView2: View {
    @State var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var category: String
    @State private var showDefaultImagePicker: Bool = false
    @State private var showImagePicker: Bool = false
    
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
                            .frame(width: imageSize+50, height: imageSize+50)
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
                    Spacer()
                }
                HStack{
                    
                    
                    Button("앨범 선택") {
                        showImagePicker = true
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
                }
                
            }
            
            
        }
    }
}
