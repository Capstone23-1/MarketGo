//
//  MemberModel.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import Foundation

// MARK: - MrMemberID
struct Member: Codable {
    var memberID: Int?
    var memberToken, memberName: String?
    var interestMarket: MrMarketID?
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


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let memberInfo = try? JSONDecoder().decode(MemberInfo.self, from: jsonData)


// MARK: - MemberPostInfo
struct MemberPostInfo: Codable {
    var memberID: Int
    var memberToken, memberName: String
    var interestMarket: Int
    var cartID: Int?
    var storeID: Int?
    var recentLatitude, recentLongitude: Double?

    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
        case memberToken, memberName, interestMarket
        case cartID = "cartId"
        case storeID = "storeId"
        case recentLatitude, recentLongitude
    }
}
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let memberInfo = try? JSONDecoder().decode(MemberInfo.self, from: jsonData)

import Foundation

// MARK: - MemberInfo
struct MemberInfo: Codable {
    var memberID: Int
    var memberToken, memberName: String?
    var interestMarket: MrMarketID?
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

// MARK: - Encode/decode helpers

class MarketModel: ObservableObject {
    @Published var currentMarket: MarketOne? = nil
}
