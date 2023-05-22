// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let goods = try? JSONDecoder().decode(Goods.self, from: jsonData)

import Foundation
import Alamofire
import SwiftUI

// MARK: - Good
struct GoodOne: Codable, Identifiable {
    var goodsID: Int?
    var goodsName: String?
    var goodsMarket: MarketOne?
    var goodsStore: StoreElement?
    var goodsFile: FileInfo?
    var goodsPrice: Int?
    var goodsUnit, goodsInfo: String?
    var updateTime: String?
    var goodsOrigin: String?
    var isAvail: Int?

    enum CodingKeys: String, CodingKey {
        case goodsID = "goodsId"
        case goodsName, goodsMarket, goodsStore, goodsFile, goodsPrice, goodsUnit, goodsInfo, updateTime, goodsOrigin, isAvail
    }
    
    var id: Int? {
           return goodsID
       }
}



struct GoodsImage: View {
    let url: URL?
    let placeholder: Image
    
    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholder = placeholder
    }
    
    @State private var imageData: Data?
    
    var body: some View {
        Group {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .onAppear {
            if let url = url {
                AF.request(url).responseData { response in
                    if case .success(let data) = response.result {
                        self.imageData = data
                    }
                }
            }
        }
    }
}


typealias Goods = [GoodOne]

// MARK: - Encode/decode helpers

//MarketId를 입력받아 특정 시장 내의 모든 goods들을 가져옴
class GoodsViewModel: ObservableObject {
    @Published var goods: [GoodOne] = []

    func fetchGoods(forStoreMarketID storeMarketID: Int) {
        let url = "http://3.34.33.15:8080/goods/all"

        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    var allGoods = try decoder.decode(Goods.self, from: data)
                    // Filter goods based on storeMarketID
                    allGoods = allGoods.filter { $0.goodsMarket?.marketID == storeMarketID }
                    DispatchQueue.main.async {
                        self.goods = allGoods
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}



class GoodsViewModel2: ObservableObject {
    @Published var goods: [GoodOne] = []

    func fetchGoods(forGoodsStoreID storeID: Int) {
        let url = "http://3.34.33.15:8080/goods/all"

        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let goodsList = try decoder.decode([GoodOne].self, from: data)
                    DispatchQueue.main.async {
                        self.goods = goodsList.filter { $0.goodsStore?.storeID == storeID }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}





class GoodsViewModel3: ObservableObject {
    @Published var goods: Goods?
    
    func fetchGoodsById(goodsId: Int) {
        let url = "http://3.34.33.15:8080/goods/\(goodsId)"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let goods = try JSONDecoder().decode(Goods.self, from: data)
                    DispatchQueue.main.async {
                        self.goods = goods
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
