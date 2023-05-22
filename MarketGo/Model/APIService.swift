
import Alamofire
import SwiftUI

// StoreInfo 구조체 생성
struct StoreInfo: Codable {
    var storeName: String
    var storeAddress1: String
    var storeAddress2: String
    var storeRatings: Double
    var storePhonenum: String
    var storeInfo: String
    var cardAvail: String
    var localAvail: String
    var storeNum: Int
    var marketId: Int
    var storeFile: Int
    var storeCategory: Int
}



class APIService {
    
    func putStoreInfo(store: StoreElement,completion: @escaping (Result<AFDataResponse<Data?>, Error>) -> Void) {
        // 파라미터 초기화
        let storeInfo = StoreInfo(storeName: "StoreName",
                                  storeAddress1: "StoreAddress1",
                                  storeAddress2: "StoreAddress2",
                                  storeRatings: 4.5,
                                  storePhonenum: "StorePhoneNum",
                                  storeInfo: "StoreInfo",
                                  cardAvail: "CardAvail",
                                  localAvail: "LocalAvail",
                                  storeNum: 1,
                                  marketId: 1,
                                  storeFile: 1,
                                  storeCategory: 1)
        
        let url = "http://3.34.33.15:8080/store"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .put, parameters: storeInfo, encoder: JSONParameterEncoder.default, headers: headers)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
