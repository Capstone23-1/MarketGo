// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let goods = try? JSONDecoder().decode(Goods.self, from: jsonData)

import Foundation
import Alamofire
import SwiftUI
import Kingfisher

// MARK: - Good
struct GoodsOne: Codable, Identifiable {
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



struct GoodsImage2: View {
    let url: URL?
    let placeholder: Image
    let imageSize: CGFloat
    
    init(url: URL?, placeholder: Image = Image(systemName: "photo"), imageSize: CGFloat = 250.0) {
        self.url = url
        self.placeholder = placeholder
        self.imageSize = imageSize
    }
    
    @State private var imageData: Data?
    
    var body: some View {
        Group {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill) // 가로에 맞추고 확대
                    .frame(maxWidth:.infinity)
                    .frame(height: imageSize) // 정사각형으로 크기 조절
                    .clipped() // 뷰의 경계 내에 클리핑
                    
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize, height: imageSize) // 여기서도 정사각형으로 크기 조절
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





typealias Goods = [GoodsOne]

// MARK: - Encode/decode helpers

//MarketId를 입력받아 특정 시장 내의 모든 goods들을 가져옴
class GoodsViewModel: ObservableObject {
    @Published var goods: [GoodsOne] = []

    func fetchGoods(forStoreMarketID storeMarketID: Int) {
        let url = "http://3.34.33.15:8080/goods/all"

        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    var allGoods = try decoder.decode(Goods.self, from: data)
                    
                    // Filter goods based on storeMarketID and isAvail != 0
                    allGoods = allGoods.filter { $0.goodsMarket?.marketID == storeMarketID && $0.isAvail != 0 }
                    
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
    
    func fetchGoodsCompare(goodsName: String, marketId: Int) {
            let goods_name = makeStringKoreanEncoded(goodsName)
            let url = "http://3.34.33.15:8080/goods/goodsCompare/\(goods_name)?marketId=\(marketId)"
            
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let goods = try decoder.decode(Goods.self, from: data)
                        
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



class GoodsViewModel2: ObservableObject {
    @Published var goods: [GoodsOne] = []

    func fetchGoods(forGoodsStoreID storeID: Int) {
        let url = "http://3.34.33.15:8080/goods/all"

        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let goodsList = try decoder.decode([GoodsOne].self, from: data)
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
