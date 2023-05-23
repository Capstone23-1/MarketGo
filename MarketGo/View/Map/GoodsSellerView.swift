import SwiftUI
import Alamofire

struct GoodsSellerView: View {
    
    @State private var goodsList = [GoodOne]()
    
    var body: some View {
        List(goodsList) { goods in
            if goods.goodsStore?.storeID == 98 {
                VStack(alignment: .leading) {
                    Text(goods.goodsName!)
                    Text(String(describing: goods.goodsPrice!))
                    Text(goods.goodsUnit!)
                }
            }
        }
        .task {
            do {
                let url = "http://3.34.33.15:8080/goods/all"
                goodsList = try await fetchGoods(url: url)
            } catch {
                print("Error fetching goods: \(error)")
            }
        }
    }
}
func fetchGoods(url: String) async throws -> [GoodOne] {
    return try await withCheckedThrowingContinuation { continuation in
        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let goods = try decoder.decode([GoodOne].self, from: data!)
                    continuation.resume(returning: goods)
                } catch {
                    continuation.resume(throwing: error)
                }
            case .failure(let error):
                continuation.resume(throwing: error)
            }
        }
    }
}
