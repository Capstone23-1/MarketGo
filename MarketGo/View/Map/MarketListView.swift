//
//  MarketListView.swift
//  MarketGo
//
//  Created by ram on 2023/05/06.
//
import SwiftUI
import Alamofire

struct MarketListView :View {
    @State var marketData: [MarketOneElement] = []

    var body: some View {
        List(marketData, id: \.marketID) { market in
            VStack(alignment: .leading) {
                Text(market.marketName)
                    .font(.headline)
                Text(market.marketAddress1)
                    .font(.subheadline)
                Text(market.marketInfo)
                    .font(.subheadline)
            }
        }
        .onAppear {
            getMarketData()
        }
    }

    func getMarketData() {
        let url = "http://3.34.33.15:8080/market/marketName/흑석시장"
        AF.request(url).responseData { response in
            guard let data = response.data else { return }
            do {
                let marketOne = try JSONDecoder().decode(MarketOne.self, from: data)
                DispatchQueue.main.async {
                    self.marketData = marketOne
                }
            } catch {
                print(error)
            }
        }
    }
}
