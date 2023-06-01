import SwiftUI
import Alamofire

struct MarketOtherTableWrapper: View {
    var data: [MarketOne]
    
    @State private var selectedMarket: MarketOne?
    @State private var isLinkActive = false
    @EnvironmentObject var marketModel: MarketModel
    @EnvironmentObject var userModel: UserModel
    @Binding var searchText:String
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
                        isLinkActive = true
                    }) {
                        Image(systemName: "arrowtriangle.forward")
                            .foregroundColor(.black)
                    }
                    .background(
                        NavigationLink(destination: MarketInfoView(selectedMarket: $selectedMarket), isActive: $isLinkActive) {
                            EmptyView()
                        }
                        .hidden()
                    )
                }
            }
        }
    }
}
