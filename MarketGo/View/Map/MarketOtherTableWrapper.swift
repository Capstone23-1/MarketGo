import SwiftUI
import Alamofire

struct MarketOtherTableWrapper: View {
    var data: [MarketOne]
    
    @State private var selectedMarket: MarketOne?
    @State private var isLinkActive = false
    @EnvironmentObject var marketModel: MarketModel
    @EnvironmentObject var userModel: UserModel
    @Binding var searchText:String
    
    
    
    var didSelectRowAt: ((Document) -> Void)?
    @State private var isLoading = false // indicator 추가
    
    @StateObject var vm = MarketSearchViewModel()
    var filteredData: [MarketOne] {
        if searchText.isEmpty {
            return data
        } else {
            return data.filter { market in
                market.marketName?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }
    
    
    var body: some View {
        ZStack{
            VStack {
                
                List(filteredData, id: \.marketName) { market in
                    HStack {
                        Text(market.marketName ?? "")
                            .onTapGesture {
                                selectedMarket = market
                            }
                        Spacer()
                        Button(action: {
                            
                            selectedMarket = market
                            
                                Task {
                                    await vm.fetchMarketData(marketName: (selectedMarket?.marketName)!)
                                    isLinkActive = true
                                }
                            
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
            if isLoading {
                
                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .frame(width: 100, height: 100)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                
                
            }
        }
    }
}
