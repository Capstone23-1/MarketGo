//
//  SellerMarketsChoiceView.swift
//  MarketGo
//
//  Created by ram on 2023/05/14.
//

import Foundation
import SwiftUI
import Alamofire
import Combine

class MarketsChoiceViewModel: ObservableObject {
    @Published var markets = MarketArray()
    @Published var searchText = ""
    
    init() {
        getMarkets()
    }
    
    func getMarkets() {
        let letter = makeStringKoreanEncoded("서울")
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
struct SellerMarketsChoiceView: View {
    @ObservedObject var viewModel = MarketsChoiceViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    TextField("Search", text: $viewModel.searchText)
                        .padding(7)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 10)
                }
                
                
                List(viewModel.markets.filter({ "\($0)".contains(viewModel.searchText) || viewModel.searchText.isEmpty }), id: \.marketName) { market in
                    Text(market.marketName ?? "")
                }
            }
            .navigationTitle("")
        }
    }
}
