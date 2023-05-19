import SwiftUI

struct StoreEnrollView: View {
    @EnvironmentObject private var storePost: StorePostViewModel
    @State private var cardAvail = false
    @State private var localAvail = false

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
                TextField("시장 내 상세주소", text: $storePost.storeAddress1)
                Picker(selection: $storePost.storeCategory, label: Text("가게 분류")) {
                    ForEach(0..<categories.count) { index in
                        Text(categories[index].name).tag(index)
                    }
                }
                TextField("전화번호 ex: 010-1234-1234", text: $storePost.storePhonenum)
            }
            
            Section(header: Text("가게 상세 정보")) {
                TextField("가게 정보", text: $storePost.storeInfo)
            }
            
            Section(header: Text("가능 여부")) {
                Toggle("카드 이용 가능 여부", isOn: $cardAvail)
                    .onChange(of: cardAvail) { newValue in
                        storePost.cardAvail = newValue ? "가능" : "이용불가"
                    }
                    .onAppear {
                        cardAvail = storePost.cardAvail == "가능"
                    }
                
                Toggle("지역 화폐 가능 여부", isOn: $localAvail)
                    .onChange(of: localAvail) { newValue in
                        storePost.localAvail = newValue ? "가능" : "이용불가"
                    }
                    .onAppear {
                        localAvail = storePost.localAvail == "가능"
                    }
            }
         
        }
    }
}
