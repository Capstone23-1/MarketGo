import SwiftUI
import Alamofire

struct StoreUpdateView: View {
    @ObservedObject var obse: ObservableStoreElement
    @State private var storeName: String = ""
    @State private var storeAddress1: String = ""
    @State var phone = ""
    @State var storeInfo = ""
    
    

    
    var body: some View {
        VStack {
            Form {
                TextField("Store Name", text: $storeName)
                TextField("Store Address 1", text: $storeAddress1)
                TextField("전화번호 ex: 010-1234-1234", text: $phone)
                TextField("가게 정보", text: $storeInfo)
                
                // Add more fields as needed
            }
            .onAppear(perform: loadStoreData)
            .navigationTitle("Update Store")
            .navigationBarItems(trailing: Button("Save Changes") {
                obse.storeElement.storeName = storeName
                obse.storeElement.storeAddress1 = storeAddress1
                obse.storeElement.storePhonenum=phone
                obse.storeElement.storeInfo=storeInfo
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
    }


    func updateStoreData() {
        
        obse.storeElement.storeName = storeName
        obse.storeElement.storeAddress1 = storeAddress1
        

        let enStoreName=makeStringKoreanEncoded(obse.storeElement.storeName!)
        let enAddress=makeStringKoreanEncoded(obse.storeElement.storeAddress1!)
        let enPhoneNum=makeStringKoreanEncoded(obse.storeElement.storePhonenum!)
        let enInfo=makeStringKoreanEncoded(obse.storeElement.storeInfo!)
        let enCard=makeStringKoreanEncoded(obse.storeElement.cardAvail!)
        let enLocal=makeStringKoreanEncoded(obse.storeElement.localAvail!)
        let url = "http://3.34.33.15:8080/store/\(String(describing: (obse.storeElement.storeID)!))?storeName=\(enStoreName)&storeAddress1=\(enAddress)&storeAddress2=\(enAddress)&storeRatings=0&storePhonenum=\(enPhoneNum)&storeInfo=\(enInfo)&cardAvail=\(enCard)&localAvail=\(enLocal)&storeNum=0&marketId=\(String(describing: (obse.storeElement.storeMarketID?.marketID)!))&storeFile=\(String(describing: (obse.storeElement.storeFile?.fileID)!))&storeCategory=\(String(describing: (obse.storeElement.storeCategory?.categoryID)!))"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        

        AF.request(url, method: .put, headers: headers)
            .validate(statusCode: 200..<300)
            .response { response in
                debugPrint(response)
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
