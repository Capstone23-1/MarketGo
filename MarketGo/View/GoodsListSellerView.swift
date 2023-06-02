import SwiftUI
import Alamofire

struct GoodsListSellerView: View {
    @State private var goodsList: [GoodsOne] = []  // 상품 리스트
    @EnvironmentObject var userViewModel: UserModel  // 유저 데이터 모델
    @State private var storeID = 0  // 스토어 ID
    @State private var searchText = ""  // 검색창 텍스트
    @State var placeHolder = "상품명으로 검색하세요"  // 검색창 텍스트 필드의 플레이스홀더
    @State private var selectedGoods: [GoodsOne] = []  // 선택된 상품 리스트
    @State var offAvail = 0  // 판매 가능한지 여부
    
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
        VStack {
            HStack {
                TextField("\(placeHolder)", text: $searchText)  // 검색창
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                Image(systemName: "magnifyingglass")  // 검색 아이콘
                    .foregroundColor(.gray)
            }
            .padding([.leading, .trailing])

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(filteredGoodsList, id: \.goodsID) { goods in  // 필터링된 상품 리스트 표시
                        HStack {
                            Image(systemName:
                                selectedGoods.contains(where: { $0.goodsID == goods.goodsID }) ?
                                    "checkmark.circle.fill" :
                                    (goods.isAvail == 0 ? "xmark.circle.fill" : "circle"))  // 선택한 상품 표시 또는 판매 불가능한 상품 표시
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(goods.isAvail == 0 ? .gray : .blue)
                            .padding()
                            .onTapGesture {
                                if let index = selectedGoods.firstIndex(where: { $0.goodsID == goods.goodsID }) {
                                    selectedGoods.remove(at: index)  // 선택된 상품이면 제거
                                } else {
                                    selectedGoods.append(goods)  // 선택되지 않은 상품이면 추가
                                }
                            }
                            VStack(alignment: .leading, spacing: 10) {
                                if let fileData = goods.goodsFile, let uploadFileURL = fileData.uploadFileURL, let url = URL(string: uploadFileURL) {
                                    URLImage(url: url)  // 상품 이미지
                                } else {
                                    Text("Loading...")
                                }
                                // 상품 이름
                                Text(goods.goodsName ?? "")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                // 상품 가격
                                Text( "\(goods.goodsUnit!) \(String(describing: goods.goodsPrice!)) 원")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            // 상품 수정 링크
                            NavigationLink(destination: EditGoodsView(viewModel: EditGoodsViewModel(goods: goods))) {
                                Text("Edit")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2) // 카드형식의 그림자 추가
                    }
                    .padding([.leading, .trailing])
                }
            }

            // 판매중인 상품에서 제거하는 버튼
            Button(action: {
                selectedGoods.forEach { goods in
                    let viewModel = OffAvailGoodsViewModel(goods: goods)
                    viewModel.isAvail = offAvail
                    Task {
                        await viewModel.updateGoods(isAvail: $offAvail)
                    }
                }
            }) {
                Text("판매중인 물품에서 제거하기")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding([.top, .bottom])
        }
        .onAppear {
            storeID = (userViewModel.currentUser?.storeID?.storeID)!  // 현재 사용자의 스토어 ID 가져오기
            Task {
                await fetchGoodsData()  // 상품 데이터 가져오기
            }
        }
        .background(Color.gray.opacity(0.1))  // 전체 배경 색상 변경
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
            }
        } catch {
            print("Failed to decode JSON: \(error)")
        }
    }
    
}
