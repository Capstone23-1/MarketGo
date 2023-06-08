import SwiftUI
import Alamofire

struct OtherMarketSearchView: View {
    @StateObject private var vm = OtherMarketSearchViewModel()
    @Binding var searchText :String
    @Binding var placeHoldr :String
    
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText,placeHolder: $placeHoldr)
            
            OtherTableWrapper(data: vm.marketList, searchText: $searchText)
        }
        .onAppear(perform: vm.loadData)
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
