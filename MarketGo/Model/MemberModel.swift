//
//  MemberModel.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import Foundation


public struct Member{
    
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

import Foundation

// MARK: - MemberInfo
struct MemberInfo: Codable {
    let memberID: Int
    let memberToken, memberName: String
    let interestMarket: InterestMarket
    let cartID: [String: Int?]
    let storeID: StoreID
    let recentLatitude, recentLongitude: Int

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
    let marketID: Int
    let marketName, marketAddress1, marketAddress2, marketLocation: String
    let marketLatitude, marketLongitude, marketRatings: JSONNull?
    let marketInfo, parking, toilet, marketPhonenum: String
    let marketGiftcard: String
    let marketType, updateTime, marketFile, marketMap: JSONNull?
    let reviewCount: JSONNull?

    enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case marketName, marketAddress1, marketAddress2, marketLocation, marketLatitude, marketLongitude, marketRatings, marketInfo, parking, toilet, marketPhonenum, marketGiftcard, marketType, updateTime, marketFile, marketMap, reviewCount
    }
}

// MARK: - StoreID
struct StoreID: Codable {
    let storeID: Int
    let storeName, storeAddress1, storeAddress2: String
    let storeCategory, storeRatings: JSONNull?
    let storePhonenum, storeInfo, cardAvail, localAvail: String
    let storeNum, storeMarketID, storeFile, reviewCount: JSONNull?

    enum CodingKeys: String, CodingKey {
        case storeID = "storeId"
        case storeName, storeAddress1, storeAddress2, storeCategory, storeRatings, storePhonenum, storeInfo, cardAvail, localAvail, storeNum
        case storeMarketID = "storeMarketId"
        case storeFile, reviewCount
    }
}
