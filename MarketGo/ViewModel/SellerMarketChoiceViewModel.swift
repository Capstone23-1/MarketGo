//
//  SellerMarketChoiceViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/05/15.
//


import SwiftUI
import Alamofire
import Combine

class SellerMarketChoiceViewModel: ObservableObject {
    @Published var markets = MarketArray()
    @Published var searchText = ""
    @Published var selectedLocation = "서울"
    @Published var selectedMarket: MarketOne?
    
    init() {
        getMarkets()
    }
    
    func getMarkets() {
        
        let letter = makeStringKoreanEncoded("\(selectedLocation)")
        let url = "http://3.34.33.15:8080/market/loc/\(letter)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: MarketArray.self) { (response) in
            switch response.result {
                case .success(let markets):
                    DispatchQueue.main.async {
                        self.markets = markets
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
