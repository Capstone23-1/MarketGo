//
//  MarketTableWrapper.swift
//  MarketGo
//
//  Created by ram on 2023/05/11.
//
import SwiftUI
import Alamofire

struct MarketSearchOtherTableWrapper: View {
    var data: [Document]
    @Binding var selected: Document?
    @EnvironmentObject var marketModel:MarketModel
    @EnvironmentObject var userModel:UserModel
    var didSelectRowAt: ((Document) -> Void)?
    
    @State private var isLinkActive = false
    @State var selectedMarket: MarketOne?
    
    @StateObject var vm = MarketSearchViewModel()
    @Binding var isLoading: Bool
    
    var body: some View {
        List(data,selection: $vm.selectedID) { market in
            HStack {
                Text("\(market.placeName)   \(market.distance)m")
                    .onTapGesture {
                        selected = market
                        vm.selectedID = market.id
//                        didSelectRowAt?(selected!)
                       
                    }
                    
                Spacer()
                Button(action: {
                    
                    
                    
                    
                    userModel.marketName = market.placeName
                    isLinkActive = true
                        isLoading = false
                    
                }) {
                    Image(systemName: "arrowtriangle.forward")
                        .foregroundColor(.black)
                }
                .background(
                    NavigationLink(destination: MarketInfoView(selectedMarket: $vm.selectedMarket, vm2: vm), isActive: $isLinkActive) {
                        EmptyView()
                    }
                        .hidden()
                )
            }
                       
        }
    }
    
    
}
