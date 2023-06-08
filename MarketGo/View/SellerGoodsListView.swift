import SwiftUI
import Alamofire

struct SellerGoodsListView: View {
    @State private var goodsList: [GoodsOne] = []  // 상품 리스트
    @EnvironmentObject var userViewModel: UserModel  // 유저 데이터 모델
    @State private var storeID = 0  // 스토어 ID
    @State private var searchText = ""  // 검색창 텍스트
    @State var placeHolder = "상품명으로 검색하세요"  // 검색창 텍스트 필드의 플레이스홀더
    @State private var selectedGoods: [GoodsOne] = []  // 선택된 상품 리스트
    @State var offAvail = 0  // 판매 가능한지 여부
    @State var isLoading = false
    
    // 검색창에 텍스트가 입력되지 않았다면, 상품리스트에서 해당 스토어의 상품을 필터링하고,
    // 텍스트가 입력되었다면, 해당 스토어의 상품 중에서 상품 이름에 검색 텍스트가 포함되는 상품을 필터링
    var filteredGoodsList: [GoodsOne] {
        if searchText.isEmpty {
            return goodsList.filter { $0.goodsStore?.storeID == storeID }
        } else {
            return goodsList.filter { $0.goodsStore?.storeID == storeID && ($0.goodsName?.contains(searchText) ?? false) }
        }
    }
    var body: some View {
        ScrollView{ ZStack{
            VStack {
                SearchBar(searchText: $searchText, placeHolder: $placeHolder)
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 20) {  // 각 아이템 간격 늘리기
                        ForEach(filteredGoodsList, id: \.goodsID) { goods in
                            HStack {
                                Image(systemName:
                                        selectedGoods.contains(where: { $0.goodsID == goods.goodsID }) ?
                                      "checkmark.circle.fill" :
                                        (goods.isAvail == 1 ? "circle" : "xmark.circle"))  // 아이콘 변경
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(goods.isAvail == 1 ? .blue : .gray)
                                .onTapGesture {
                                    if let index = selectedGoods.firstIndex(where: { $0.goodsID == goods.goodsID }) {
                                        selectedGoods.remove(at: index)  // 선택된 상품이면 제거
                                    } else {
                                        selectedGoods.append(goods)  // 선택되지 않은 상품이면 추가
                                    }
                                }
                                
                                HStack {
                                    if let fileData = goods.goodsFile, let uploadFileURL = fileData.uploadFileURL, let url = URL(string: uploadFileURL) {
                                        URLImage(url: url)  // 상품 이미지
                                    } else {
                                        Text("Loading...")
                                    }
                                }
                                .background(Color.white.opacity(0.5))  // 이미지 배경을 반투명하게
                                .cornerRadius(10)  // 둥근 모서리 추가
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    // 상품 이름
                                    Text(goods.goodsName ?? "")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    // 상품 가격
                                    Text( "\(goods.goodsUnit!) \(String(describing: goods.goodsPrice!)) 원")
                                        .font(.footnote)
                                        .foregroundColor(.gray)  // 색상 변경
                                }
                                Spacer()
                                // 상품 수정 링크
                                NavigationLink(destination: EditGoodsView(viewModel: EditGoodsViewModel(goods: goods))) {
                                    Text("수정")
                                        .foregroundColor(.blue)
                                        .padding(.all, 10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.blue, lineWidth: 1)
                                        )
                                    
                                }
                                
                            }
                            .padding(.horizontal)
                            .background(Color.white.opacity(0.1))  // 배경에 반투명 색상 추가
                            .cornerRadius(10)  // 둥근 모서리
                        }
                    }
                    .padding(.top)
                }
                // 판매중인 상품에서 제거하는 버튼
                Button(action: {
                    
                    selectedGoods.forEach { goods in
                        let viewModel = OffAvailGoodsViewModel(goods: goods)
                        viewModel.isAvail = offAvail
                        isLoading = true
                        
                            Task {
                                await viewModel.updateGoods(isAvail: $offAvail)
                                selectedGoods.removeAll() // 선택된 상품 제거
                                
                            }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                               Task {
                                   await fetchGoodsData()
                                   isLoading = false
                               }
                           }

                    }
                    
                }) {
                    Text("판매중인 물품에서 제거하기")
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                }
                .padding()
                
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
        }}
        .onAppear {
            storeID = (userViewModel.currentUser?.storeID?.storeID)!
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                Task {
                    await fetchGoodsData()
                }
                isLoading = false
            }
            selectedGoods.removeAll() // 선택된 상품 제거
            
        }
    }
    
    // 상품 데이터를 비동기로 가져오는 함수
    func fetchGoodsData() async {
        let url = "http://3.34.33.15:8080/goods/all"
        let request = AF.request(url)
        
        do {
            // 서버로부터 데이터 받아오기
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
            // 데이터를 GoodsOne 형식으로 디코딩
            let goodsList = try JSONDecoder().decode([GoodsOne].self, from: data)
            DispatchQueue.main.async {
                // isAvail에 따라 상품 리스트를 정렬. isAvail이 0인 것들이 리스트의 하단에 위치하도록.
                self.goodsList = goodsList.sorted { $0.isAvail ?? 0 > $1.isAvail ?? 0 }
                print("goods 리스트 get 성공")
            }
        } catch {
            print("Failed to decode JSON: \(error)")
        }
    }
    
}

class SellerGoodsListViewModel: ObservableObject {
    @Published var goodsList: [GoodsOne] = []
    @Published var storeID = 0
    @Published var searchText = ""
    @Published var selectedGoods: [GoodsOne] = []
    @Published var offAvail = 0
    @Published var isLoading = false
    @Published var selectedGoodsIDs: [Int] = []
    @Published var meneName = ""
    
    
    var placeHolder = "상품명으로 검색하세요"
    func fetchGoodsData() async {
            let url = "http://3.34.33.15:8080/goods/all"
            let request = AF.request(url)
            
            do {
                // 서버로부터 데이터 받아오기
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
                // 데이터를 GoodsOne 형식으로 디코딩
                let goodsList = try JSONDecoder().decode([GoodsOne].self, from: data)
                DispatchQueue.main.async {
                    // isAvail에 따라 상품 리스트를 정렬. isAvail이 0인 것들이 리스트의 하단에 위치하도록.
                    self.goodsList = goodsList.sorted { $0.isAvail ?? 0 > $1.isAvail ?? 0}
                    print("goods 리스트 get 성공")
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }

    func postMenu() {
        let enName = makeStringKoreanEncoded(meneName)
        var url = "http://3.34.33.15:8080/menu?menuName=\(enName)=&storeId=\(self.storeID ?? 0)"
        
        let maxGoodsCount = 10
        for index in 0..<maxGoodsCount {
            let goodsId = index < selectedGoodsIDs.count ? selectedGoodsIDs[index] : 0
            url += "&goodsId\(index+1)=\(String(describing: goodsId))"
        }
        print(url)
        
        // Now you can use Alamofire to make the request
        
    }
    
}
