import SwiftUI

struct PostStoreView: View {
    @EnvironmentObject private var storePost: StorePostViewModel
    @State private var cardAvail = false
    @State private var localAvail = false
    @State private var storeCategory = 0
    @Binding var storeName :String

    var body: some View {
        Form {
            Section(header: Text("가게 정보")) {
                TextField("가게 이름", text: $storeName)
                TextField("시장 내 상세주소", text: $storePost.storeAddress1)
                Picker(selection: $storeCategory, label: Text("가게 분류")) {
                    ForEach(0..<9) { index in
                        Text(categories[index].name).tag(index)
                    }
                }.onChange(of:storeCategory) { _ in
                    storePost.storeCategory=storeCategory
                    storePost.storeName=storeName

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
                        storePost.storeName=storeName
                    }
            }

        }
    }
}
