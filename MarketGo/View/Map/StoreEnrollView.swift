import SwiftUI
// TODO: storeNum은 지도가 등록됐을 때 수정창에서 하도록
struct StoreEnrollView: View {
    //    @StateObject private var vm = SellerSignUpViewModel()
    @EnvironmentObject private var storePost: StorePostViewModel
    @State private var storeName = ""
    @State private var storeAddress1 = ""
    @State private var storeAddress2 = ""
    @State private var storeCategoryIndex = 0
    @State private var storePhonenum = ""
    @State private var storeInfo = ""
    @State private var cardAvail = false
    @State private var localAvail = false
    @State private var storeNum = 0
    @State private var marketGiftcards: [String] = []
    @StateObject var viewModel = StorePostViewModel()
    @State private var moveToCoiceView = false
    @State private var selectedMarket: MarketOne?
    @State private var marketName: String = ""
    
    // 분류 카테고리 리스트
    var categories = [
        (id: 0, name: "분류"),
        (id: 1, name: "농산물"),
        (id: 2, name: "수산물"),
        (id: 3, name: "축산물"),
        (id: 4, name: "반찬"),
        (id: 5, name: "가공식품"),
        (id: 6, name: "건강식품"),
        (id: 7, name: "생활용품"),
        (id: 8, name: "기타"),
    ]
    
    var body: some View {
        Form {
            
            Section(header: Text("가게 정보")) {
                TextField("가게 이름", text: $storePost.storeName)
//                HStack{
//                    TextField("소속시장", text: $marketName)
//                        .autocapitalization(.none)
//
//
//                    Button(action: {
//                        self.moveToCoiceView = true
//                    }) {
//                        Text("찾기")
//                            .frame(maxWidth: 50)
//                            .background(Color.accentColor)
//                            .foregroundColor(.white)
//                            .cornerRadius(8.0)
//                    }
//                    .sheet(isPresented: $moveToCoiceView) {
//                        SellerMarketChoiceView(selectedMarket: $selectedMarket, isPresented: $moveToCoiceView, marketName: $marketName)
//                    }
//                }
                TextField("시장 내 상세주소", text: $storePost.storeAddress1)
                
                
                // 가게 분류 선택
                Picker(selection: $storePost.storeCategory, label: Text("가게 분류")) {
                    ForEach(0..<categories.count) { index in
                        Text(categories[index].name).tag(index)
                    }
                }
                
                // 전화번호 입력 (ex: 010-1234-5678)
                TextField("전화번호 ex: 010-1234-1234", text: $storePost.storePhonenum)
            }
            
            Section(header: Text("가게 상세 정보")) {
                TextField("가게 정보", text: $storePost.storeInfo)
            }
            
            Section(header: Text("가능 여부")) {
                Toggle("카드 이용 가능 여부", isOn: $cardAvail)
                    .onChange(of: cardAvail) { newValue in
                        storePost.cardAvail = newValue ? "가능" : "이용불가"
                        print(storePost.cardAvail)
                    }
                
                Toggle("지역 화폐 가능 여부", isOn: $localAvail)
                    .onChange(of: localAvail) { newValue in
                        storePost.localAvail = newValue ? "가능" : "이용불가"
                    }
            }
            
            //            Section(header: Text("마켓 상품권")) {
            //                // 다중 선택 가능한 체크박스 목록
            //                VStack(alignment: .leading) {
            //                    ForEach(["온누리상품권"], id: \.self) { giftcard in
            //                        HStack {
            //                            Button(action: {
            //                                toggleMarketGiftcard(giftcard)
            //                            }) {
            //                                Image(systemName: marketGiftcards.contains(giftcard) ? "checkmark.square" : "square")
            //                            }
            //                            Text(giftcard)
            //                        }
            //                    }
            //                }
            //            }
            
            //            Section(header: Text("가게 번호")) {
            //                Stepper(value: $storeNum, in: 0...10) {
            //                    Text("가게 번호: \(storeNum)")
            //                }
            //            }
            
            //            // 저장 버튼
            //            Section {
            //                Button(action: saveStoreElement) {
            //                    Text("저장")
            //                }
            //            }
        }
    }
    
    
    func saveStoreElement() {
        // StoreElement 객체를 생성하여 입력된 값들을 저장
        //        let storeElement = StoreElement(
        //            storeID: nil,
        //            storeName: storeName,
        //            storeAddress1: storeAddress1,
        //            storeAddress2: storeAddress2,
        //            storeCategory: categories[storeCategoryIndex].id,
        //            storePhonenum: storePhonenum,
        //            storeInfo: storeInfo,
        //            cardAvail: cardAvail ? "가능" : "이용불가",
        //            localAvail: localAvail ? "가능" : "이용불가",
        //            storeNum: storeNum
        //        )
        //
        //        // 서버로 전송할 URL 생성
        //        let urlString = "http://3.34.33.15:8080/store"
        //        let queryParams = [
        //            "storeName": storeElement.storeName ?? "",
        //            "storeAddress1": storeElement.storeAddress1 ?? "",
        //            "storeAddress2": storeElement.storeAddress2 ?? "",
        //            "storeRatings": "\(storeElement.storeRatings ?? 0.0)",
        //            "storePhonenum": storeElement.storePhonenum ?? "",
        //            "storeInfo": storeElement.storeInfo ?? "",
        //            "cardAvail": storeElement.cardAvail ?? "",
        //            "localAvail": storeElement.localAvail ?? "",
        //            "storeNum": "\(storeElement.storeNum ?? 0)",
        //            "marketId": marketGiftcards.joined(separator: ","),
        //            "storeCategory": "\(storeElement.storeCategory ?? 0)"
        //        ]
        //        let urlStringWithParams = urlString + "?" + queryParams.map({ "\($0.key)=\($0.value)" }).joined(separator: "&")
        //        guard let url = URL(string: urlStringWithParams) else {
        //            // URL이 유효하지 않을 경우 에러 처리
        //            return
        //        }
        //
        //        // StoreID를 반환받을 비동기 HTTP POST 요청
        //        URLSession.shared.dataTask(with: url) { data, response, error in
        //            if let data = data {
        //                do {
        //                    let decodedResponse = try JSONDecoder().decode(StoreElement.self, from: data)
        //                    // StoreID를 반환받은 후에 사용할 수 있음
        //                    let storeID = decodedResponse.storeID
        //                    // ...
        //                } catch {
        //                    // 디코딩 에러 처리
        //                }
        //            }
        //        }.resume()
        //
        //        // 저장 후 입력 필드 초기화
        //        clearForm()
    }
    
    func clearForm() {
        storeName = ""
        storeAddress1 = ""
        storeAddress2 = ""
        storeCategoryIndex = 0
        storePhonenum = ""
        storeInfo = ""
        cardAvail = false
        localAvail = false
        storeNum = 0
        marketGiftcards = []
    }
}
