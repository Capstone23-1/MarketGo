// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let goods = try? JSONDecoder().decode(Goods.self, from: jsonData)

import Foundation
import Alamofire
import SwiftUI

// MARK: - Good
struct Good: Codable, Identifiable {
    var goodsID: Int?
    var goodsName: String?
    var goodsMarket: GoodsMarket?
    var goodsStore: GoodsStore?
    var goodsFile: GoodsFile?
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

// MARK: - GoodsFile
struct GoodsFile: Codable {
    var fileID: Int?
    var originalFileName, uploadFileName, uploadFilePath: String?
    var uploadFileURL: String?

    enum CodingKeys: String, CodingKey {
        case fileID = "fileId"
        case originalFileName, uploadFileName, uploadFilePath
        case uploadFileURL = "uploadFileUrl"
    }
}


struct GoodsImage: View {
    let url: URL?
    let placeholder: Image

    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let url = url, let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

// MARK: - GoodsMarket
struct GoodsMarket: Codable {
    var marketID: Int?
    var marketName, marketAddress1, marketAddress2, marketLocation: String?
    var marketLatitude, marketLongitude, marketRatings: Double?
    var marketInfo, parking, toilet, marketPhonenum: String?
    var marketGiftcard, marketType, updateTime: String?
    var marketFile, marketMap: GoodsFile?
    var reviewCount: Int?

    enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case marketName, marketAddress1, marketAddress2, marketLocation, marketLatitude, marketLongitude, marketRatings, marketInfo, parking, toilet, marketPhonenum, marketGiftcard, marketType, updateTime, marketFile, marketMap, reviewCount
    }
}

// MARK: - GoodsStore
struct GoodsStore: Codable {
    var storeID: Int?
    var storeName, storeAddress1, storeAddress2: String?
    var storeCategory: StoreCategory?
    var storeRatings: Double?
    var storePhonenum, storeInfo, cardAvail, localAvail: String?
    var storeNum: Int?
    var storeMarketID: GoodsMarket?
    var storeFile: GoodsFile?
    var reviewCount: Int?

    enum CodingKeys: String, CodingKey {
        case storeID = "storeId"
        case storeName, storeAddress1, storeAddress2, storeCategory, storeRatings, storePhonenum, storeInfo, cardAvail, localAvail, storeNum
        case storeMarketID = "storeMarketId"
        case storeFile, reviewCount
    }
}

// MARK: - StoreCategory
struct StoreCategory: Codable {
    var categoryID: Int?
    var categoryName: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName
    }
}

typealias Goods = [Good]

// MARK: - Encode/decode helpers

//MarketId를 입력받아 특정 시장 내의 모든 goods들을 가져옴
class GoodsViewModel: ObservableObject {
    @Published var goods: [Good] = []

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
    @Published var goods: [Good] = []

    func fetchGoods(forGoodsStoreID storeID: Int) {
        let url = "http://3.34.33.15:8080/goods/all"

        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let goodsList = try decoder.decode([Good].self, from: data)
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


