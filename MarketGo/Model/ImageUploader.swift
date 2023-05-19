import Alamofire
import UIKit

class ImageUploader {
    func uploadImageToServer(image: UIImage, category: String, id: String, completionHandler: @escaping (Result<FileInfo, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completionHandler(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Image compression failed"])))
            return
        }

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "files", fileName: "image.jpg", mimeType: "image/jpeg")
            multipartFormData.append(category.data(using: .utf8)!, withName: "category")
            multipartFormData.append(id.data(using: .utf8)!, withName: "id")
        }, to: "http://3.34.33.15:8080/uploads").responseDecodable(of: [FileInfo].self) { response in
            switch response.result {
            case .success(let fileInfoArray):
                completionHandler(.success(fileInfoArray[0]))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
