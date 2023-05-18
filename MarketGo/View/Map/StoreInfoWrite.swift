import Alamofire
import SwiftUI
import Foundation
import Alamofire

class StoreEnrollViewModel: ObservableObject {
    @Published var storeId: String?

    var storeName: String = "소람상회"
    var storeAddress1: String = "논현 1동"
    var storeAddress2: String = "반포 1동"
    var storeRatings: Double = 0.0
    var storePhonenum: String = "02-0202-0202"
    var storeInfo: String = "가격이 비싼편"
    var cardAvail: String = "가능"
    var localAvail: String = "가능"
    var storeNum: Int = 0
    var marketId: Int = 17
    var storeFile: Int = 24
    var storeCategory: Int = 0

    func enrollStore() {
        let parameters: [String: Any] = [
            "storeName": storeName,
            "storeAddress1": storeAddress1,
            "storeAddress2": storeAddress2,
            "storeRatings": storeRatings,
            "storePhonenum": storePhonenum,
            "storeInfo": storeInfo,
            "cardAvail": cardAvail,
            "localAvail": localAvail,
            "storeNum": storeNum,
            "marketId": marketId,
            "storeFile": storeFile,
            "storeCategory": storeCategory
        ]

        let url = "http://3.34.33.15:8080/store"

        AF.request(url, method: .post, parameters: parameters)
            .validate()
            .responseDecodable(of: StoreElement.self) { (response) in
                switch response.result {
                case .success(let storeElement):
                    print(storeElement) // 이렇게 하면 응답이 StoreElement 타입으로 제공됩니다.
                case .failure(let error):
                    print(error)
                }
            }

    }
}

import SwiftUI

struct StoreEnrollViewTest: View {
    @StateObject var viewModel = StoreEnrollViewModel()

    var body: some View {
        VStack {
            Button("Enroll Store") {
                viewModel.enrollStore()
            }

            if let storeId = viewModel.storeId {
                Text("Store ID: \(storeId)")
            } else {
                Text("Store ID not yet fetched")
            }
        }
    }
}
