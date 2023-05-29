import SwiftUI
import Alamofire

struct OtherMarketSearchView: View {
    @StateObject private var vm = OtherMarketSearchViewModel()
    @Binding var searchText :String
    @Binding var placeHoldr :String
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText,placeHolder: $placeHoldr)
            HStack {
                Spacer()
                Picker(selection: $vm.sortOption, label: Text("지역")) {
                    Text("서울").tag(0)
                    Text("제주").tag(1)
                }
                .padding(.horizontal)
                .foregroundColor(.gray)
                .onChange(of: vm.sortOption) { newValue in
                    if newValue == 1 {
                        vm.location = "제주"
                        vm.loadData()
                    } else {
                        vm.location = "서울"
                        vm.loadData()
                    }
                }
            }
            MarketOtherTableWrapper(data: vm.marketList, searchText: $searchText)
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
