import SwiftUI
import Alamofire

struct StoreUpdateView: View {
    @ObservedObject var observableStoreElement: ObservableStoreElement
    @State private var storeName: String = ""
    @State private var storeAddress1: String = ""
    @State private var storeAddress2: String = ""

    
    var body: some View {
        VStack {
            Form {
                TextField("Store Name", text: $storeName)
                TextField("Store Address 1", text: $storeAddress1)
                TextField("Store Address 2", text: $storeAddress2)
                // Add more fields as needed
            }
            .onAppear(perform: loadStoreData)
            .navigationTitle("Update Store")
            .navigationBarItems(trailing: Button("Save Changes") {
                observableStoreElement.storeElement.storeName = storeName
                observableStoreElement.storeElement.storeAddress1 = storeAddress1
                observableStoreElement.storeElement.storeAddress2 = storeAddress2
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
        storeName = observableStoreElement.storeElement.storeName ?? ""
        storeAddress1 = observableStoreElement.storeElement.storeAddress1 ?? ""
        storeAddress2 = observableStoreElement.storeElement.storeAddress2 ?? ""
    }


    func updateStoreData() {
//        storeElement.storeName = storeName
        print(storeName)
//        print(storeElement.storeName)
//        storeElement.storeAddress1 = storeAddress1
//        storeElement.storeAddress2 = storeAddress2
//
//        let url = "http://3.34.33.15:8080/store"
//        let headers: HTTPHeaders = ["Content-Type": "application/json"]
//        guard let parameters = try? storeElement.asDictionary() else { return }
//
//        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
//            .response { response in
//                debugPrint(response)
//            }
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
