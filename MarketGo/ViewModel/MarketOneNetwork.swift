////
////  NetworkService.swift
////  MarketGo
////
////  Created by ram on 2023/05/06.
////
//import Foundation
//import SwiftUI
//import Alamofire
//
//class MarketOneNetwork{
//    
//    typealias SearchCompletionHandler = (Result<MarketElement, Error>) -> Void
//    
//    func searchMarket(completionHandler: @escaping SearchCompletionHandler) {
//
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/x-www-form-urlencoded;charset=utf-8",
//        ]
//
//        
//        var resultArray: [MarketElement] = [] // 검색 결과를 담을 배열
//        
//        // Meta.isEnd가 false가 될 때까지 반복해서 데이터를 받는 함수
//        func fetchData() {
//            AF.request("http://3.34.33.15:8080/market/marketName/흑석시장",
//                       method: .get,
//                       encoding: URLEncoding.default)
//                .validate(statusCode: 200..<300)
//                .responseJSON { response in
//                    switch response.result {
//                    case .success(_):
//                        if let data = response.data {
//                            do {
//                                let decoder = JSONDecoder()
//                                let result = try decoder.decode(Market.self, from: data)
//                                print(result)
//                                print("-----------")
//
//                            } catch let error {
//                                // completionHandler를 통해 에러 반환
//                                completionHandler(.failure(error))
//                            }
//                        }
//                    case .failure(let error):
//                        // completionHandler를 통해 에러 반환
//                        completionHandler(.failure(error))
//                    }
//                    
//                }
//        }
//        
//        fetchData() // 함수 호출
//    }
//    
//    func makeStringKoreanEncoded(_ string: String) -> String {
//        return string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? string
//    }
//}
