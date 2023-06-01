// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let indexInfo = try? JSONDecoder().decode(IndexInfo.self, from: jsonData)

import Foundation

// MARK: - IndexInfo
struct IndexInfo: Codable {
    var indexID: Int?
    var memberID: MemberID3?
    var storeId1, storeId2, storeId3, storeId4: StoreID3?
    var storeId5, storeId6, storeId7, storeId8: StoreID3?
    var storeId9, storeId10: StoreID3?

    enum CodingKeys: String, CodingKey {
        case indexID = "indexId"
        case memberID = "memberId"
        case storeId1, storeId2, storeId3, storeId4, storeId5, storeId6, storeId7, storeId8, storeId9, storeId10
    }
}

// MARK: - MemberID
struct MemberID3: Codable {
    var memberID: Int?
    var memberToken, memberName: String?
    var interestMarket: InterestMarket3?
    var cartID: CartID3?
    var storeID: StoreID3?
    var recentLatitude, recentLongitude: Int?

    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
        case memberToken, memberName, interestMarket
        case cartID = "cartId"
        case storeID = "storeId"
        case recentLatitude, recentLongitude
    }
}

// MARK: - CartID
struct CartID3: Codable {
    var cartID: Int?
    var cartDate: String?
    var goodsId1, goodsId2, goodsId3, goodsId4: [String: Int?]?
    var goodsId5, goodsId6, goodsId7, goodsId8: [String: Int?]?
    var goodsId9, goodsId10: [String: Int?]?
    var unit1, unit2, unit3, unit4: Int?
    var unit5, unit6, unit7, unit8: Int?
    var unit9, unit10: Int?

    enum CodingKeys: String, CodingKey {
        case cartID = "cartId"
        case cartDate, goodsId1, goodsId2, goodsId3, goodsId4, goodsId5, goodsId6, goodsId7, goodsId8, goodsId9, goodsId10, unit1, unit2, unit3, unit4, unit5, unit6, unit7, unit8, unit9, unit10
    }
}

// MARK: - InterestMarket
struct InterestMarket3: Codable {
    var marketID: Int?
    var marketName, marketAddress1, marketAddress2, marketLocation: String?
    var marketLatitude, marketLongitude: Double?
    var marketRatings: Double?
    var marketInfo, parking, toilet, marketPhonenum: String?
    var marketGiftcard, marketType, updateTime: String?
    var marketFile, marketMap: MarketFile3?
    var reviewCount: Int?

    enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case marketName, marketAddress1, marketAddress2, marketLocation, marketLatitude, marketLongitude, marketRatings, marketInfo, parking, toilet, marketPhonenum, marketGiftcard, marketType, updateTime, marketFile, marketMap, reviewCount
    }
}

// MARK: - MarketFile
struct MarketFile3: Codable {
    var fileID: Int?
    var originalFileName, uploadFileName, uploadFilePath: String?
    var uploadFileURL: String?

    enum CodingKeys: String, CodingKey {
        case fileID = "fileId"
        case originalFileName, uploadFileName, uploadFilePath
        case uploadFileURL = "uploadFileUrl"
    }
}



// MARK: - StoreID
struct StoreID3: Codable {
    var storeID: Int?
    var storeName: String?
    var storeAddress1: String?
    var storeAddress2: String?
    var storeCategory: StoreCategory3?
    var storeRatings: Double?
    var storePhonenum, storeInfo: String?
    var cardAvail, localAvail: String?
    var storeNum: Int?
    var storeMarketID: InterestMarket3?
    var storeFile: MarketFile3?
    var reviewCount: Int?

    enum CodingKeys: String, CodingKey {
        case storeID = "storeId"
        case storeName, storeAddress1, storeAddress2, storeCategory, storeRatings, storePhonenum, storeInfo, cardAvail, localAvail, storeNum
        case storeMarketID = "storeMarketId"
        case storeFile, reviewCount
    }
}

// MARK: - StoreCategory
struct StoreCategory3: Codable {
    var categoryID: Int?
    var categoryName: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName
    }
}

