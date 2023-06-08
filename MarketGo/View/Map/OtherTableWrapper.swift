import SwiftUI
import Alamofire

struct OtherTableWrapper: View {
    var data: [MarketOne]
    
    @State private var selectedMarket: MarketOne?
    @State private var isLinkActive = false
    @EnvironmentObject var marketModel: MarketModel
    @EnvironmentObject var userModel: UserModel
    @Binding var searchText:String
    
 
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
                            userModel.currentUser?.interestMarket=market
                            marketModel.currentMarket=market
                            isLinkActive = true
                            userModel.marketName=market.marketName!
                               
                            
                        }) {
                            Image(systemName: "arrowtriangle.forward")
                                .foregroundColor(.black)
                        }
                        .background(
                            NavigationLink(destination: OtherInfoView(selectedMarket: $vm.selectedMarket, vm2: vm), isActive: $isLinkActive) {
                                EmptyView()
                            }
                                .hidden()
                        )
                    }
                }
            }

        }
    }
}
