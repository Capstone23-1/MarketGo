//
//  MarketForm.swift
//  MarketGo
//
//  Created by ram on 2023/05/18.
//


import SwiftUI

struct StoreEnrollForm: View {
    // StoreElement에 저장될 속성들을 선언합니다.
    @State private var storeID: Int?
    @State private var storeName = ""
    @State private var storeAddress1 = ""
    @State private var storeAddress2 = ""
    @State private var storeCategory = 0
    @State private var storePhonenum = ""
    @State private var storeInfo = ""
    @State private var cardAvail = true
    @State private var localAvail = true
    @State private var storeNum = 0
    
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
    
    // 지역상품권 리스트
    var marketGiftcardOptions = [
        "온누리상품권",
        "제로페이",
        "지역사랑상품권"
    ]
    
    // 전화번호 입력 포맷용 정규식
    let phoneRegex = try! NSRegularExpression(pattern: "(\\d{3})(\\d{3,4})(\\d{4})")
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("가게 정보")) {
                    TextField("가게 이름", text: $storeName)
                    TextField("가게 주소 1", text: $storeAddress1)
                    TextField("가게 주소 2", text: $storeAddress2)
                    Picker(selection: $storeCategory, label: Text("가게 분류")) {
                        ForEach(0..<categories.count) { index in
                            Text(categories[index].name).tag(index)
                        }
                    }
                }
                
                Section(header: Text("연락처 정보")) {
                    TextField("가게 전화번호", text: $storePhonenum)
                        .onChange(of: storePhonenum, perform: formatPhoneNumber)
                    TextField("가게 정보", text: $storeInfo)
                }
                
                Section(header: Text("가능 여부")) {
                    Toggle("카드 이용 가능 여부", isOn: $cardAvail)
                    Toggle("지역상품권 이용 가능 여부", isOn: $localAvail)
                }
                
                Section(header: Text("기타 정보")) {
                    Picker(selection: $storeNum, label: Text("지역상품권 선택")) {
                        ForEach(0..<marketGiftcardOptions.count) { index in
                            Text(marketGiftcardOptions[index]).tag(index)
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        saveStoreElement()
                    }, label: {
                        Text("저장")
                    })
                }
            }
            .navigationTitle("가게 등록")
        }
    }
    
    // 전화번호 입력 포맷을 적용하는 메서드
    private func formatPhoneNumber(value: String) {
        let range = NSRange(location: 0, length: value.utf16.count)
        var formattedNumber = value
        
        // "XXX-XXXX-XXXX" 형식으로 포맷팅
        phoneRegex.enumerateMatches(in: value, options: [], range: range) { match, _, _ in
            if let matchRange = match?.range, matchRange.length == 10 {
                let formattedString = phoneRegex.replacementString(for: match!, in: formattedNumber, offset: 0, template: "$1-$2-$3")
                formattedNumber = formattedString
            }
        }
        
        storePhonenum = formattedNumber
    }
    
    // StoreElement에 입력된 정보를 저장하는 메서드
    private func saveStoreElement() {
//        let storeElement = StoreElement(
//            storeID: storeID,
//            storeName: storeName,
//            storeAddress1: storeAddress1,
//            storeAddress2: storeAddress2,
//            storeCategory: categories[storeCategory].id,
//            storePhonenum: storePhonenum,
//            storeInfo: storeInfo,
//            cardAvail: cardAvail ? "가능" : "이용불가",
//            localAvail: localAvail ? "가능" : "이용불가",
//            storeNum: storeNum
//        )
        
        // TODO: StoreElement를 어딘가에 저장하거나 처리하는 로직을 추가
        
        // 저장 후에 필요한 추가 로직을 구현할 수 있습니다.
    }
}
