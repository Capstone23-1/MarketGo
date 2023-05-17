//
//  MemberModel.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import Foundation


public struct Member {
    
    let memberToken: String
    var memberName: String
    var interestMarket: Int
    let cartId: Int
    var storeId: Int
    var recentLatitude: Double
    var recentLongitude: Double

}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let memberInfo = try? JSONDecoder().decode(MemberInfo.self, from: jsonData)


// MARK: - MemberInfo
struct MemberInfo: Codable {
    var memberID: Int?
    var memberToken, memberName: String?
    var interestMarket: InterestMarket?
    var cartID: [String: Int?]?
    var storeID: StoreID?
    var recentLatitude, recentLongitude: Int?

    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
        case memberToken, memberName, interestMarket
        case cartID = "cartId"
        case storeID = "storeId"
        case recentLatitude, recentLongitude
    }
}

// MARK: - InterestMarket
struct InterestMarket: Codable {
    var marketID: Int?
    var marketName, marketAddress1, marketAddress2, marketLocation: String?
    var marketLatitude, marketLongitude, marketRatings: JSONNull?
    var marketInfo, parking, toilet, marketPhonenum: String?
    var marketGiftcard: String?
    var marketType, updateTime, marketFile, marketMap: JSONNull?
    var reviewCount: JSONNull?

    enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case marketName, marketAddress1, marketAddress2, marketLocation, marketLatitude, marketLongitude, marketRatings, marketInfo, parking, toilet, marketPhonenum, marketGiftcard, marketType, updateTime, marketFile, marketMap, reviewCount
    }
}

// MARK: - StoreID
struct StoreID: Codable {
    var storeID: Int?
    var storeName, storeAddress1, storeAddress2: String?
    var storeCategory, storeRatings: JSONNull?
    var storePhonenum, storeInfo, cardAvail, localAvail: String?
    var storeNum, storeMarketID, storeFile, reviewCount: JSONNull?

    enum CodingKeys: String, CodingKey {
        case storeID = "storeId"
        case storeName, storeAddress1, storeAddress2, storeCategory, storeRatings, storePhonenum, storeInfo, cardAvail, localAvail, storeNum
        case storeMarketID = "storeMarketId"
        case storeFile, reviewCount
    }
}


// MARK: - Encode/decode helpers

class MarketModel: ObservableObject {
    @Published var currentMarket: MarketOne? = nil
}
