//
//  MarketInfoView.swift
//  MarketGo
//
//  Created by ram on 2023/05/06.
//
import SwiftUI

struct MarketInfoView: View {
    @State private var selectedTab = 0
    @Binding var selected: Document?
    @Binding var selectedMarket: MarketOne?
    @EnvironmentObject var marketModel: MarketModel
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                Image("상도시장메인")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Picker(selection: $selectedTab, label: Text("탭")) {
                    Text("시장정보").tag(0)
                    Text("지도보기").tag(1)
                    Text("가는길 찾기").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedTab {
                    case 0:
                        MarketListView(marketData: $selectedMarket)
                    case 1:
                        Image("상도시장지도")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        Spacer().frame(width:20)
                    case 2:
                        FindPathView(selectedMarket: $selectedMarket)
                    default:
                        Text("잘못된 선택")
                }
                Button(action: {
                    self.marketModel.currentMarket = selectedMarket!
//                    print("selectedMarket:\(String(describing: selectedMarket?.marketName))")
                }) {
                    NavigationLink(destination: MainView()) {
                        Text("시장 선택")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10.0)
                    }
                }

            }
            
        }
        .navigationTitle((selected?.placeName ?? "시장정보"))
    }
}
