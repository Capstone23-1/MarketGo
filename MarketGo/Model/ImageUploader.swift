//
//  ImageUploader.swift
//  MarketGo
//
//  Created by ram on 2023/05/19.
//

import UIKit
import Alamofire
class ImageUploader {
    
    func uploadImageToServer(image: UIImage, category: String, id: String, completion: @escaping (_ newImage: FileInfo) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "files", fileName: "image.jpg", mimeType: "image/jpeg")
            multipartFormData.append(category.data(using: .utf8)!, withName: "category")
            multipartFormData.append(id.data(using: .utf8)!, withName: "id")
        }, to: "http://3.34.33.15:8080/uploads").responseDecodable(of: [FileInfo].self) { response in
            switch response.result {
                case .success(let fileInfoArray):
                    completion(fileInfoArray[0]) // 이미지 업로드가 완료되면 완료 클로저 호출
                case .failure(let error):
                    print(error)
            }
        }
    }
}
