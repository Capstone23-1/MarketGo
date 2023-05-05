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
func fetchData(with marketName: String, completion: @escaping (Result<MarketOne, Error>) -> Void) {
    let letter = makeStringKoreanEncoded(marketName)
    let url = "http://3.34.33.15:8080/market/marketName/\(letter)"
    AF.request(url).responseDecodable(of: MarketOne.self) { response in
        switch response.result {
        case .success(let data):
            completion(.success(data))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
