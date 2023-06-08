import SwiftUI
import Alamofire

struct OtherMarketSearchView: View {
    @StateObject private var otherViewModel = OtherMarketSearchViewModel()
    @Binding var searchText: String
    @Binding var placeHoldr: String
    @StateObject var vm = MarketSearchViewModel()
    @State private var selectedMarket: MarketOne?
    @State private var isLinkActive: Bool = false
    @EnvironmentObject var marketModel: MarketModel
    @EnvironmentObject var userModel: UserModel
    
    var filteredData: [MarketOne] {
        if searchText.isEmpty {
            return otherViewModel.marketList
        } else {
            return otherViewModel.marketList.filter { market in
                market.marketName?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }
    
    var body: some View {
        if isLinkActive {
            OtherInfoView(selectedMarket: $selectedMarket, vm2: vm)
        } else {
            NavigationView{
                VStack {
                    SearchBar(searchText: $searchText, placeHolder: $placeHoldr)

                    List(filteredData, id: \.marketName) { market in
                        Button(action: {
                            selectedMarket = market
                            userModel.currentUser?.interestMarket = market
                            marketModel.currentMarket = market
                            userModel.marketName = market.marketName!
                            isLinkActive = true
                        }) {
                            Text(market.marketName ?? "")
                        }
                    }
                }
                .onAppear(perform: otherViewModel.loadData)
            }
        }
    }
}




class OtherMarketSearchViewModel: ObservableObject {
    @Published var marketList = [MarketOne]()
    @Published var sortOption: Int = 0
    @Published var location = "서울"

    func loadData() {
        let enLocation = makeStringKoreanEncoded(location)
        AF.request("http://3.34.33.15:8080/market/loc/\(enLocation)").validate().responseDecodable(of: [MarketOne].self) { response in
            switch response.result {
            case .success(let markets):
                DispatchQueue.main.async {
                    self.marketList = markets
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
}
