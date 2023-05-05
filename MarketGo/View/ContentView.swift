////
////  ContentView.swift
////  MarketGo
////
////  Created by ram on 2023/03/27.
////
//
//import SwiftUI
//import Combine
//
//class MarketOneViewModel: ObservableObject {
//    @Published var marketOneData: MarketOne = []
//
//    func fetchMarketOneData() {
//        let urlString = "http://3.34.33.15:8080/market/marketName/흑석시장"
//
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                do {
//                    let decodedResponse = try JSONDecoder().decode(MarketOne.self, from: data)
//                    DispatchQueue.main.async {
//                        self.marketOneData = decodedResponse
//                    }
//                } catch {
//                    print("Error while decoding JSON: \(error)")
//                }
//            } else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//            }
//        }.resume()
//    }
//}
//
//struct ContentView: View {
//    @StateObject private var marketOneViewModel = MarketOneViewModel()
//
//    var body: some View {
//        VStack {
//            Button("Fetch Data") {
//                marketOneViewModel.fetchMarketOneData()
//            }
//
//            List(marketOneViewModel.marketOneData, id: \.marketID) { market in
//                VStack(alignment: .leading) {
//                    Text(market.marketName)
//                        .font(.headline)
//                    Text(market.marketAddress1)
//                        .font(.subheadline)
//                    Text(market.marketAddress2)
//                        .font(.subheadline)
//                    // Add other properties as needed
//                }
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
