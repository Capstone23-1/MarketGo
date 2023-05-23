//import Foundation
//import Combine
//import Alamofire
//class GoodsPostViewModel: ObservableObject {
//    
//    @Published var newGoods :GoodsPost? // newStore를 옵셔널 타입으로 선언
//    
//
//    func enrollStore(completion: @escaping (Result<StoreElement, Error>) -> Void) {
//
//        let parameters: [String: Any] = [
//            "goodsName": newGoods?.goodsName!,
//            "marketId": newGoods?.marketId!,
//            "storeId": newGoods?.storeId!,
//            "goodsFile": newGoods?.goodsFileId!,
//            "goodsPrice": newGoods?.goodsPrice!,
//            "goodsUnit": newGoods?.goodsUnit!,
//            "goodsInfo": newGoods?.goodsInfo!,
//            "goodsOrigin": newGoods?.goodsOrigin!,
//            "isAvail": newGoods?.isAvail!,
//        ]
//
//        let url = "http://3.34.33.15:8080/goods"
//
//        AF.request(url, method: .post, parameters: parameters)
//            .validate()
//            .responseDecodable(of: StoreElement.self) { (response) in
//                switch response.result {
//                    case .success(let storeElement):
//                        print(storeElement)
////                        self.newStore = storeElement
//                        DispatchQueue.main.async {
////                            self.newStore = storeElement
//                        }
//                        completion(.success(storeElement))
//                    case .failure(let error):
//                        print(error)
//                        completion(.failure(error))
//                }
//            }
//    }
//
//
//}
