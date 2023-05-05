//
//  NetworkService.swift
//  MarketGo
//
//  Created by ram on 2023/05/06.
//
import Foundation
import SwiftUI
import Alamofire
func makeStringKoreanEncoded(_ string: String) -> String {
    return string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? string
}
class MarketOneNetwork{
    
    typealias SearchCompletionHandler = (Result<MarketOneElement, Error>) -> Void
    
    func getMarketInfo(completionHandler: @escaping SearchCompletionHandler) {
        let radius: Int =  10000
        let size: Int = 5
        let sort: String = "accuracy"
        let requestPage = 1
        let marketName="흑석시장"
        var page: Int = 1 // 검색 시작 페이지
        var isEnd: Bool = false // 모든 검색 결과를 다 받았는지 확인하기 위한 변수
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded;charset=utf-8",
            "Authorization": "KakaoAK 1712da9b3de78f2c91296dfe29222efa",
        ]
        
        let encodeQueryKeyword = makeStringKoreanEncoded(marketName)
        
        var resultArray: [Document] = [] // 검색 결과를 담을 배열
        
        // Meta.isEnd가 false가 될 때까지 반복해서 데이터를 받는 함수
        func fetchData() {
            AF.request("http://3.34.33.15:8080/market/marketName/\(encodeQueryKeyword)",
                       method: .get,
                       encoding: URLEncoding.default,
                       headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success(_):
                        if let data = response.data {
                            do {
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(MarketOneElement.self, from: data)
                                print(result)
//                                print("-----------")
//                                resultArray.append(contentsOf: result)
                                
//                                if !isEnd && page<=requestPage  { // Meta.isEnd가 false가 아니라면 다시 fetchData 함수를 호출
//                                    fetchData()
//                                } else { // 모든 검색 결과를 받았다면 completionHandler를 통해 결과값 반환
//                                    let finalResult = MarketOneElement(documents: resultArray, meta: result.meta)
//                                    completionHandler(.success(finalResult))
//                                }
                            } catch let error {
                                // completionHandler를 통해 에러 반환
                                completionHandler(.failure(error))
                            }
                        }
                    case .failure(let error):
                        // completionHandler를 통해 에러 반환
                        completionHandler(.failure(error))
                    }
                    
                }
        }
        
        fetchData() // 함수 호출
    }
    
    
}
