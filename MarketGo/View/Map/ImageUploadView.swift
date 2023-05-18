import SwiftUI
import Alamofire
import UIKit

struct ImageUploadView: View {
    @State var showImagePicker: Bool = false
    @State var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var category: String 
    @Binding var id: Int
    var stringId: Binding<String> {
        Binding<String>(
            get: { String(id) },
            set: { id = Int($0) ?? 0 }
        )
    }

    let imageSize = 100.0

    var body: some View {
        
        VStack {
            // 이미지가 선택되었을 경우 이미지 표시
            if let image = image {
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
                if let image = self.image {
                    self.uploadImageToServer(image: image, category: "store", id: String(id))
                }
            }) {
                ImagePicker(selectedImage: self.$image, sourceType: self.sourceType)
            }

            TextField("ID", text: stringId)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()


            Button("서버에 이미지 업로드") {
                if let image = self.image {
                    self.uploadImageToServer(image: image, category: "store", id: String(id))
                }
            }
            .padding()
        }
    }

    // 서버로 이미지 업로드
    func uploadImageToServer(image: UIImage, category: String, id: String) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "files", fileName: "image.jpg", mimeType: "image/jpeg")
            multipartFormData.append(category.data(using: .utf8)!, withName: "category")
            multipartFormData.append(id.data(using: .utf8)!, withName: "id")
        }, to: "http://3.34.33.15:8080/uploads").response { response in
            debugPrint(response)
        }
    }

    // 카테고리와 ID를 포함하여 서버에서 이미지를 로드
    func loadImage(category: String, id: String, image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NSError(domain: "com.example", code: 400, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }

        let url = "http://3.34.33.15:8080/uploads"
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]

        let parameters: [String: String] = [
            "category": category,
            "id": id
        ]

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "files", fileName: "image.jpeg", mimeType: "image/jpeg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
        }, to: url, headers: headers).responseString { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
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
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
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
