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

class SellerMarketChoiceViewModel: ObservableObject {
    @Published var markets = MarketArray()
    @Published var searchText = ""
    @Published var selectedLocation = "서울"
    
    
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
struct SellerMarketChoiceView: View {
    @ObservedObject var viewModel = SellerMarketChoiceViewModel()
    @State private var isLinkActive = false
    
    var body: some View {
        
        VStack {
            HStack{
                Picker(selection: $viewModel.selectedLocation, label: Text("Location")) {
                    Text("서울").tag("서울")
                    Text("제주").tag("제주")
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(.black)
                .onChange(of: viewModel.selectedLocation) { _ in
                    viewModel.getMarkets()
                }
                TextField("Search", text: $viewModel.searchText)
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
            }
            
            
            List(viewModel.markets.filter({ "\($0)".contains(viewModel.searchText) || viewModel.searchText.isEmpty }), id: \.marketName) { market in
                HStack{
                    Text(market.marketName ?? "")
                    
                    Spacer()
                    Button(action: {
                        
                        isLinkActive = true
                    }) {
                        Image(systemName: "arrowtriangle.forward")
                            .foregroundColor(.black)
                    }
                    .background(
                        
                        NavigationLink(destination: Detail(), isActive: $isLinkActive) {
                            EmptyView()
                        }
                            .hidden()
                    )
                    
                }
                
                
            }
        }
        
    }
}

