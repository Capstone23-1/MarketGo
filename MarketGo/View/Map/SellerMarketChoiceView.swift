//
//  SellerMarketChoiceView.swift
//  MarketGo
//
//  Created by ram on 2023/05/14.
//

import SwiftUI
import Alamofire
import Combine

class MarketChoiceViewModel: ObservableObject {
    @Published var markets: MarketArray = []

    func fetchMarkets() {
        let letter = makeStringKoreanEncoded("서울")
        let url = "http://3.34.33.15:8080/market/loc/\(letter)"
        print(url)
        AF.request(url, method: .get).responseDecodable(of: MarketArray.self) { response in
            switch response.result {
            case .success(let markets):
                self.markets = markets
            case .failure(let error):
                print(error)
            }
        }
    }
}
struct SellerMarketChoiceView: View {
    @StateObject private var viewModel = MarketChoiceViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.markets, id: \.marketName) { market in
                Text(market.marketName ?? "")
            }
            .onAppear {
                viewModel.fetchMarkets()
            }
            .navigationTitle("")
        }
    }
}



struct SellerMarketChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        SellerMarketChoiceView()
    }
}
