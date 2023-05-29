//
//  MarketTableWrapper.swift
//  MarketGo
//
//  Created by ram on 2023/05/11.
//
import SwiftUI
import Alamofire

struct MarketSearchTableWrapper: View {
    var data: [Document]
    @Binding var selected: Document?
    var didSelectRowAt: ((Document) -> Void)?
    @State private var isLoading = false // indicator 추가
    @State private var isLinkActive = false
    @State var selectedMarket: MarketOne?
    @EnvironmentObject var marketModel: MarketModel
    
    var body: some View {
        List(data) { market in
            HStack {
                Text("\(market.placeName)   \(market.distance)m")
                    .onTapGesture {
                        selected = market
                        didSelectRowAt?(market)
                    }
                Spacer()
                Button(action: {
                    self.fetchMarketData(marketName: market.placeName)
                    selected = market
                    
                    isLinkActive = true
                }) {
                    Image(systemName: "arrowtriangle.forward")
                        .foregroundColor(.black)
                }
                .background(
                    NavigationLink(destination: MarketInfoView(selected: $selected, selectedMarket: $selectedMarket), isActive: $isLinkActive) {
                        EmptyView()
                    }
                        .hidden()
                )
            }
        }
    }
    
    private func fetchMarketData(marketName: String) {
        let letter = makeStringKoreanEncoded(marketName)
        let url = "http://3.34.33.15:8080/market/marketName/\(letter)"
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [MarketOne].self) { response in
                switch response.result {
                    case .success(let market):
                        // 이 경우 market은 MarketOneElement의 배열입니다. 첫 번째 요소를 선택하거나 적절하게 처리하세요.
                        if let firstMarket = market.first {
                            self.selectedMarket = firstMarket
                            self.marketModel.currentMarket = firstMarket // fetched market data is saved to currentMarket
                            //                        print(firstMarket)
                        }
                    case .failure(let error):
                        //                    print("Error: \(error)")
                        print("error")
                }
                
            }
    }
}
