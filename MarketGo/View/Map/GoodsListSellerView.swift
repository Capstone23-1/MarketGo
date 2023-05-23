import SwiftUI
import Alamofire

struct GoodsListSellerView: View {
    @State private var goodsList: [GoodOne] = []
    @EnvironmentObject var userViewModel: UserModel
    @State private var storeID = 0
    @State private var selectedGoodsIDs: [Int] = []
    @State private var searchText = ""
    @State var placeHolder = "상품명으로 검색하세요"
    
    var filteredGoodsList: [GoodOne] {
        if searchText.isEmpty {
            return goodsList.filter { $0.goodsStore?.storeID == storeID }
        } else {
            return goodsList.filter { $0.goodsStore?.storeID == storeID && ($0.goodsName?.contains(searchText) ?? false) }
        }
    }
    
    var body: some View {
        NavigationView{VStack {
            SearchBar(searchText: $searchText, placeHolder: $placeHolder)
                .padding(.horizontal)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(filteredGoodsList, id: \.goodsID) { goods in
                        HStack {
                            Image(systemName: selectedGoodsIDs.contains(goods.goodsID!) ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    toggleGoodsSelection(goodsID: goods.goodsID!)
                                }
                            HStack {
                                if let fileData = goods.goodsFile, let uploadFileURL = fileData.uploadFileURL, let url = URL(string: uploadFileURL) {
                                    URLImage(url: url)
                                } else {
                                    Text("Loading...")
                                }
                            }
                            VStack(alignment: .leading, spacing: 10) {
                                // 가게 이름 표시
                                Text(goods.goodsName ?? "")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Text( "\(goods.goodsUnit!) \(String(describing: goods.goodsPrice!)) 원")
                            }
                            
                            Spacer()
                            NavigationLink(destination: GoodsPostView()) {
                                Text("Edit")
                                    .foregroundColor(.blue)
                                    .padding(.all, 10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.blue, lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .onDelete(perform: delete)
                    
                }
                
                
            }
        }}
        .onAppear {
            storeID = (userViewModel.currentUser?.storeID?.storeID)!
            Task {
                await fetchGoodsData()
            }
        }
        Button(action: {
            print(selectedGoodsIDs)
        }) {
            Text("Print Selected Goods")
        }
    }
    
    func fetchGoodsData() async {
        let url = "http://3.34.33.15:8080/goods/all"
        let request = AF.request(url)
        
        do {
            let data = try await withCheckedThrowingContinuation { continuation in
                request.responseData { response in
                    switch response.result {
                        case .success(let data):
                            continuation.resume(returning: data)
                        case .failure(let error):
                            continuation.resume(throwing: error)
                    }
                }
            }
            let goodsList = try JSONDecoder().decode([GoodOne].self, from: data)
            DispatchQueue.main.async {
                self.goodsList = goodsList
            }
        } catch {
            print("Failed to decode JSON: \(error)")
        }
    }
    
    func toggleGoodsSelection(goodsID: Int) {
        if selectedGoodsIDs.contains(goodsID) {
            selectedGoodsIDs.removeAll { $0 == goodsID }
        } else {
            selectedGoodsIDs.append(goodsID)
        }
    }
    func delete(at offsets: IndexSet) {
        goodsList.remove(atOffsets: offsets)
    }
}
