import SwiftUI
import Alamofire

struct StoreUpdateView: View {
    
    @ObservedObject var obse: ObservableStoreElement
    @EnvironmentObject var userViewModel: UserModel
    @State private var showSheet = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var imageCate = StoreCategory(categoryID: 5,categoryName: "store")
    @State private var storeName: String = ""
    @State private var storeAddress1: String = ""
    @State var phone = ""
    @State var storeInfo = ""
    @State var storeCategory = 0
    @State var storeNum = ""
    @State private var cardAvail = false
    @State private var localAvail = false
    
    
    
    var body: some View {
        VStack {
            Form {
               
                TextField("Store Name", text: $storeName)
                TextField("Store Address 1", text: $storeAddress1)
                TextField("전화번호 ex: 010-1234-1234", text: $phone)
                TextField("가게 정보", text: $storeInfo)
                Picker(selection: $storeCategory, label: Text("가게 분류")) {
                    ForEach(0..<9) { index in
                        Text(categories[index].name).tag(index)
                    }
                }
                TextField("가게 번호", text: $storeNum)
                Section(header: Text("가능 여부")) {
                    Toggle("카드 이용 가능 여부", isOn: $cardAvail)
                    Toggle("지역 화폐 가능 여부", isOn: $localAvail)
                }
            }
            .onAppear(perform: loadStoreData)
            .navigationTitle("Update Store")
            .navigationBarItems(trailing: Button("Save Changes") {
                obse.storeElement.storeName = storeName
                obse.storeElement.storeAddress1 = storeAddress1
                obse.storeElement.storePhonenum=phone
                obse.storeElement.storeInfo=storeInfo
                obse.storeElement.storeCategory?.categoryID=storeCategory
                obse.storeElement.storeNum=Int(storeNum)
                obse.storeElement.cardAvail =  cardAvail ? "가능" : "이용불가"
                obse.storeElement.localAvail =  localAvail ? "가능" : "이용불가"
                updateStoreData()
            })
            
            Button(action: updateStoreData) {
                Text("Update")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
    
    func loadStoreData() {
        storeName = obse.storeElement.storeName ?? ""
        storeAddress1 = obse.storeElement.storeAddress1 ?? ""
        phone=obse.storeElement.storePhonenum ?? ""
        storeInfo=obse.storeElement.storeInfo ?? ""
        storeCategory=obse.storeElement.storeCategory!.categoryID
        storeNum=String(describing:obse.storeElement.storeNum!)
        
        cardAvail = obse.storeElement.cardAvail == "가능"
        localAvail = obse.storeElement.localAvail == "가능"
    }
    
    
    func updateStoreData() {
        
        obse.storeElement.storeName = storeName
        obse.storeElement.storeAddress1 = storeAddress1
        obse.storeElement.storeCategory?.categoryID=storeCategory
        obse.storeElement.storeNum=Int(storeNum)
        
        obse.storeElement.cardAvail =  cardAvail ? "가능" : "이용불가"
        obse.storeElement.localAvail =  localAvail ? "가능" : "이용불가"
        let enStoreName=makeStringKoreanEncoded(obse.storeElement.storeName!)
        let enAddress=makeStringKoreanEncoded(obse.storeElement.storeAddress1!)
        let enPhoneNum=makeStringKoreanEncoded(obse.storeElement.storePhonenum!)
        let enInfo=makeStringKoreanEncoded(obse.storeElement.storeInfo!)
        let enCard=makeStringKoreanEncoded(obse.storeElement.cardAvail!)
        let enLocal=makeStringKoreanEncoded(obse.storeElement.localAvail!)
        let url = "http://3.34.33.15:8080/store/\(String(describing: (obse.storeElement.storeID)!))?storeName=\(enStoreName)&storeAddress1=\(enAddress)&storeAddress2=\(enAddress)&storeRatings=0&storePhonenum=\(enPhoneNum)&storeInfo=\(enInfo)&cardAvail=\(enCard)&localAvail=\(enLocal)&storeNum=\(storeNum)&marketId=\(String(describing: (obse.storeElement.storeMarketID?.marketID)!))&storeFile=\(String(describing: (obse.storeElement.storeFile?.fileID)!))&storeCategory=\(String(describing: (obse.storeElement.storeCategory?.categoryID)!))"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        
        AF.request(url, method: .put, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: StoreElement.self) {response in
                switch response.result {
                    case .success(let updatedStore):
                        print("Update successful: \(updatedStore)")
                        DispatchQueue.main.async {
                            obse.storeElement = updatedStore
                            userViewModel.currentUser?.storeID=updatedStore
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        
    }
}

extension StoreElement {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
class ObservableStoreElement: ObservableObject {
    @Published var storeElement: StoreElement
    
    init(storeElement: StoreElement) {
        self.storeElement = storeElement
    }
}
