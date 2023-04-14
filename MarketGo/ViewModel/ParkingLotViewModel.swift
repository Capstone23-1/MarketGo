//
//  ParkingLotViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/04/12.
//

import Foundation
import SwiftUI
import Alamofire

class ParkingLotViewModel{
    
    typealias SearchCompletionHandler = (Result<ParkingLotJSONData, Error>) -> Void
    
    //카테고리로 주차장 찾기(카카오맵)
    func searchParkingLot(location:CoordinateInfo,queryKeyword: String, completionHandler: @escaping SearchCompletionHandler) {
        let radius: Int =  10000 //중심 좌표로부터의 반경거리,미터 단위
        let page: Int = 1//결과 페이지 번호(1~45),기본값 1
        let size: Int = 15//한 페이지에 보여질 문서의 개수(1~15),기본값 15
        let sort: String = "distance"//결과 정렬 순서(distance,accuracy),기본값:accuracy
        
        //        let category = GroupCode["주차장"]!
        //x:lng(경도),y:lat(위도)
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded;charset=utf-8",
            "Authorization": "KakaoAK 1712da9b3de78f2c91296dfe29222efa",
        ]
        let encodeQueryKeyword = makeStringKoreanEncoded(queryKeyword)
        //&category_group_code=\(category)
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json?page=\(page)&size=\(size)&sort=\(sort)&query=\(encodeQueryKeyword)&x=\(location.lng)&y=\(location.lat)&radius=\(radius)",
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
                            let result = try decoder.decode(ParkingLotJSONData.self, from: data)
                            // completionHandler를 통해 결과값 반환
                            completionHandler(.success(result))
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
    
    func makeStringKoreanEncoded(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? string
    }
}
