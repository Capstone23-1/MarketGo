import SwiftUI
import Alamofire

struct StoreUpdateView: View {
    @Binding var storeElement: StoreElement
    
    var body: some View {
        VStack {
            Form {
                TextField("Store Name", text: $storeElement.storeName.bound)
                TextField("Store Address 1", text: $storeElement.storeAddress1.bound)
                TextField("Store Address 2", text: $storeElement.storeAddress2.bound)
                // Add more fields as needed
            }
            .onAppear(perform: loadStoreData)
            .navigationTitle("Update Store")
            .navigationBarItems(trailing: Button("Save Changes") {
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
        
    }
    
    func updateStoreData() {
        let url = "http://3.34.33.15:8080/store"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        guard let parameters = try? storeElement.asDictionary() else { return }
        
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
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

extension Optional where Wrapped == String {
    var bound: String {
        get {
            return self ?? ""
        }
        set {
            self = newValue
        }
    }
}
