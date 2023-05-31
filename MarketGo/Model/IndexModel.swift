// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let indexInfo = try? JSONDecoder().decode(IndexInfo.self, from: jsonData)

//import Foundation
//
//// MARK: - IndexInfo
//struct IndexInfo: Codable {
//    var indexID: Int?
//    var memberID: MemberInfo?
//    var storeId1, storeId2, storeId3, storeId4,storeId5, storeId6, storeId7, storeId8,storeId9, storeId10: StoreElement?
//
//    enum CodingKeys: String, CodingKey {
//        case indexID = "indexId"
//        case memberID = "memberId"
//        case storeId1, storeId2, storeId3, storeId4, storeId5, storeId6, storeId7, storeId8, storeId9, storeId10
//    }
//}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let indexInfo = try? JSONDecoder().decode(IndexInfo.self, from: jsonData)

import Foundation

// MARK: - IndexInfo
struct IndexInfo: Codable {
    var indexID: Int?
    var memberID: MemberInfo?
    var storeId1, storeId2, storeId3, storeId4: StoreStore?
    var storeId5, storeId6, storeId7, storeId8: StoreStore?
    var storeId9, storeId10: StoreStore?

    enum CodingKeys: String, CodingKey {
        case indexID = "indexId"
        case memberID = "memberId"
        case storeId1, storeId2, storeId3, storeId4, storeId5, storeId6, storeId7, storeId8, storeId9, storeId10
    }
}

// MARK: - StoreID
struct StoreStore: Codable {
    var storeID,storeNum, storeMarketID: Int?
    var storeName, storeAddress1, storeAddress2,storeCategory: String?
    var storeRatings: Double?
    var storePhonenum, storeInfo, cardAvail, localAvail: String?
    var  storeFile: FileInfo
    var reviewCount: Int?

    enum CodingKeys: String, CodingKey {
        case storeID = "storeId"
        case storeName, storeAddress1, storeAddress2, storeCategory, storeRatings, storePhonenum, storeInfo, cardAvail, localAvail, storeNum
        case storeMarketID = "storeMarketId"
        case storeFile, reviewCount
    }
}


