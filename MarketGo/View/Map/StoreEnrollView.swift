import SwiftUI

struct StoreEnrollView: View {
    // StoreElement의 프로퍼티에 대한 바인딩 변수들
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
                TextField("가게 이름", text: $storeName)
                TextField("주소1", text: $storeAddress1)
                TextField("주소2", text: $storeAddress2)
                
                // 가게 분류 선택
                Picker(selection: $storeCategoryIndex, label: Text("가게 분류")) {
                    ForEach(0..<categories.count) { index in
                        Text(categories[index].name).tag(index)
                    }
                }
                
                // 전화번호 입력 (ex: 010-1234-5678)
                TextField("전화번호", text: $storePhonenum)
                    .onChange(of: storePhonenum, perform: { value in
                        // 정규식을 사용하여 입력된 전화번호 형식을 유지
                        let formattedText = value.replacingOccurrences(
                            of: #"(\d{3})(\d{4})(\d{4})"#,
                            with: "$1-$2-$3",
                            options: .regularExpression
                        )
                        storePhonenum = formattedText
                    })
            }
            
            Section(header: Text("가게 상세 정보")) {
                TextField("가게 정보", text: $storeInfo)
            }
            
            Section(header: Text("가능 여부")) {
                Toggle("카드 이용 가능 여부", isOn: $cardAvail)
                Toggle("지역 이용 가능 여부", isOn: $localAvail)
            }
            
            Section(header: Text("마켓 상품권")) {
                // 다중 선택 가능한 체크박스 목록
                VStack(alignment: .leading) {
                    ForEach(["온누리상품권", "제로페이", "지역사랑상품권"], id: \.self) { giftcard in
                        HStack {
                            Button(action: {
                                toggleMarketGiftcard(giftcard)
                            }) {
                                Image(systemName: marketGiftcards.contains(giftcard) ? "checkmark.square" : "square")
                            }
                            Text(giftcard)
                        }
                    }
                }
            }
            
            Section(header: Text("가게 번호")) {
                Stepper(value: $storeNum, in: 0...10) {
                    Text("가게 번호: \(storeNum)")
                }
            }
            
            // 저장 버튼
            Section {
                Button(action: saveStoreElement) {
                    Text("저장")
                }
            }
        }
    }
    
    func toggleMarketGiftcard(_ giftcard: String) {
        if marketGiftcards.contains(giftcard) {
            marketGiftcards.removeAll(where: { $0 == giftcard })
        } else {
            marketGiftcards.append(giftcard)
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
