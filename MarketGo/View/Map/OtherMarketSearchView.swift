import SwiftUI
import Alamofire

struct OtherMarketSearchView: View {
    @StateObject private var viewModel = OtherMarketSearchViewModel()

    var body: some View {
        List(viewModel.marketList, id: \.marketID) { market in
            VStack(alignment: .leading) {
                Text(market.marketName ?? "")
                Text(market.marketLocation ?? "")
            }
        }
        .onAppear(perform: viewModel.loadData)
    }
}

class OtherMarketSearchViewModel: ObservableObject {
    @Published var marketList = [MarketOne]()

    func loadData() {
        let location = makeStringKoreanEncoded("서울")
        AF.request("http://3.34.33.15:8080/market/loc/\(location)").validate().responseDecodable(of: [MarketOne].self) { response in
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
