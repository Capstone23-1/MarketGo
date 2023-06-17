import SwiftUI
import Alamofire

struct MarketSearchTableWrapper: View {
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
        let sortedData = data.sorted { (market1, market2) -> Bool in
            guard let distance1 = Int(market1.distance), let distance2 = Int(market2.distance) else {
                return false
            }
            return distance1 < distance2
        }
        
        List(sortedData, selection: $vm.selectedID) { market in
            HStack {
                Text("\(market.placeName)   \(market.distance)m")
                    .onTapGesture {
                        selected = market
                        vm.selectedID = market.id
                    }
                    
                Spacer()
                Button(action: {
                    vm.fetchMarketData(marketName: market.placeName)
                    userModel.NMap = market
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
