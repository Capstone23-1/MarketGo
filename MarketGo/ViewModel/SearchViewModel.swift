//
//  SearchViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//
// 이곳은 메소드를 한번에 모아놓는 곳
// 나중에 기능별로 분류하여 사용
import Foundation
import SwiftUI
import Alamofire

//화면 터치시 키보드 숨김
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication
            .shared
            .sendAction(#selector(UIResponder
                .resignFirstResponder),
                        to: nil,
                        from: nil,
                        for: nil)
    }
    func getTest() {
        let url = "https://jsonplaceholder.typicode.com/" //주소입력
        let target = "posts/1/comments"
        var targetUrl = url+target
        
        AF.request("https://jsonplaceholder.typicode.com/comments")
            .responseDecodable(of: [Comment].self) {
                response in
            switch response.result {
            case .success(let comments):
                    print(comments[4])
                //print("Parsed comments: \(comments)")
            case .failure(let error):
                print("Error parsing comments: \(error.localizedDescription)")
            }
        }
//    func getTest2() {
//        let url = "https://jsonplaceholder.typicode.com/" //주소입력
//        let target = "posts/1/comments"
//        let targetUrl = url+target
//
//        AF.request("https://jsonplaceholder.typicode.com/comments")
//            .responseDecodable(of: [Comment].self) {
//                response in
//            switch response.result {
//            case .success(let comments):
//                    print(comments[4])
//                //print("Parsed comments: \(comments)")
//            case .failure(let error):
//                print("Error parsing comments: \(error.localizedDescription)")
//            }
//        }
//        AF.request(url+target,
//                  method: .get,
//                  parameters: nil,
//                  encoding: URLEncoding.default,
//                  headers: ["Content-Type":"application/json", "Accept":"application/json"])
//           .validate(statusCode: 200..<300)
//           .responseJSON { (json) in
//               print(json)
//               //여기서 받아온 데이터로 무엇을 할지 작성하시면 됩니다.
//        }
//
//        AF.request(targetUrl,
//                  method: .get,
//                  parameters: nil,
//                  encoding: URLEncoding.default,
//                  headers: ["Content-Type":"application/json", "Accept":"application/json"])
//           .validate(statusCode: 200..<300)
//           .responseDecodable(of: getModel.self) { response in
//               if let gett = response.value{
//                   print(gett.name)
//
//               }
//           }
            //method : 통신방식
            //parametrs : 보낼 데이터 값
            //encoding : URLEncoding
            //headers : 어떤형식으로 받을지
            //validate : 확인코드
            //responseJSON : 데이터 받는 부분
        }
}
#endif
