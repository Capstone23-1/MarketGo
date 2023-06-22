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
    let secretKey = "bmh6QXBsanJvUWhYRVJKV0t0VUVOdmRkTkNnWkx1TGo="
    let apiURL = "http://clovaocr-api-kr.ncloud.com/external/v1/23282/04668696fc6bca02a6408cadd868b3107aa7b7c77c14a93bddcc55140044c07d"
    
    @Published var image: UIImage = UIImage(named: "1월제철음식.png") ?? UIImage()
    @Published var stringResult: String = ""
    
    var image64: String {
        guard let data = image.pngData() else { return "" }
        return data.base64EncodedString()
    }
    
    func changeImageToText() {
        
        let naver = Naver(images: [images(format: "png", name: "1", data: image64)], lang: "ko", requestId: "string", timestamp: "0", version: "V2")
        
        let encoder = JSONEncoder()
        
        guard let jsonData = try? encoder.encode(naver),
              let jsonString = String(bytes: jsonData, encoding: .utf8) else {
            return
        }
        
        var requestBody = jsonString
        
        // URL
        guard let url = URL(string: apiURL) else { return }
        
        // URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(secretKey, forHTTPHeaderField: "X-OCR-SECRET")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestBody.data(using: .utf8)
        
        // POST 전송
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            // 에러처리
            if let error = error {
                print("An error has occurred: \(error.localizedDescription)")
                return
            }
            
            // response status code 검증
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                      print("Response error")
                      return
            }
            
            // data 검증 및 사용
            if let data = data {
                
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    if let json = try? decoder.decode(Response.self, from: data) {
                        // field 갯수만큼 for 문 돌려서 추출
                        print(json)
                        var result = ""
                        for field in json.images[0].fields {
                            result += field.inferText
                        }
                        self?.stringResult = result
                    }
                }
            }
        }
        task.resume()
    }
}
