//
//  MarketSearchViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/05/30.
//


import SwiftUI
import Alamofire

class MarketSearchViewModel: ObservableObject {
    @Published var selectedMarket: MarketOne?
    @Published var selectedID: String?
    func fetchMarketData(marketName: String) {
        let letter = makeStringKoreanEncoded(marketName)
        let url = "http://3.34.33.15:8080/market/marketName/\(letter)"
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [MarketOne].self) { response in
                debugPrint(response)
                switch response.result {
                    case .success(let market):
                        // 이 경우 market은 MarketOneElement의 배열입니다. 첫 번째 요소를 선택하거나 적절하게 처리하세요.
                        if let firstMarket = market.first {
                            self.selectedMarket = firstMarket
                            print("3.여기는 페치마켓데이터함수 self.selectedMarket=\(self.selectedMarket)")
                            
                        }
                    case .failure(let error):
                        //                    print("Error: \(error)")
                        print("error")
                }
                
            }
    }
}
