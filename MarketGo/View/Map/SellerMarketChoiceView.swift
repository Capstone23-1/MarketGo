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
struct SellerMarketChoiceView: View {
    @ObservedObject var viewModel = SellerMarketChoiceViewModel()
    @Binding var selectedMarket: MarketOne?  // 외부에서 전달받은 선택된 마켓 정보를 저장할 바인딩 변수
    @State private var isLinkActive = false
    @Binding var isPresented: Bool  // 외부에서 전달받은 모달 창 표시 상태를 저장할 바인딩 변수
    @Binding var marketName: String
    var body: some View {
        
        VStack {
            Spacer()
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
                        selectedMarket = market  // 선택한 마켓을 저장
                        isLinkActive = false
                        isPresented = false  // 모달 창 닫기
                        marketName=(selectedMarket?.marketName)!
                    }) {
                        Image(systemName: "arrowtriangle.forward")
                            .foregroundColor(.black)
                    }
                    
                    
                    
                }
                
                
            }
        }
        
    }
}

