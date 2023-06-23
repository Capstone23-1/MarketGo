//
//  NaverViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/06/22.
//

import Foundation
import Combine
import SwiftUI

class NaverViewModel: ObservableObject {
    let secretKey = "cHViVklGVlJ6bUNoVWxPT0hiREliVmVNWEtOYkxlR3Q="
    let apiURL = "https://rkki68p87d.apigw.ntruss.com/custom/v1/22822/b0c7e90f9af730a1d209f2e8fdf0b9b51036f38fd1de93895f573063a5c83179/general"
    
    @Published var image: UIImage = UIImage()
    @Published var stringResult: String = ""
    
    var image64: String {
        guard let data = image.pngData() else { return "" }
        return data.base64EncodedString()
    }
    
    func changeImageToText(completion: @escaping (String?) -> Void) {
        
        let naver = Naver(images: [images(format: "jpg", name: "1", data: image64)], lang: "ko", requestId: "string", timestamp: "0", version: "V2")
        
        let encoder = JSONEncoder()
        
        guard let jsonData = try? encoder.encode(naver),
              let jsonString = String(bytes: jsonData, encoding: .utf8) else {
            completion(nil)
            return
        }
        
        var requestBody = jsonString
        
        // URL
        guard let url = URL(string: apiURL) else {
            completion(nil)
            return
        }
        
        // URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(secretKey, forHTTPHeaderField: "X-OCR-SECRET")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestBody.data(using: .utf8)
        
        // POST 전송
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // 에러처리
            if let error = error {
                print("An error has occurred: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // response status code 검증
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("Response error")
                completion(nil)
                return
            }
            
            // data 검증 및 사용
            if let data = data {
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(Response.self, from: data) {
                    // field 갯수만큼 for 문 돌려서 추출
                    var result = ""
                    for field in json.images[0].fields {
                        
                        result += field.inferText
                        if field.lineBreak == true {
                            result += " "
                        }
                    }
                    print(result)
                    completion(result)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

}
