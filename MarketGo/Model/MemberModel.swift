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
    var storeID: StoreElement?
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
    var interestMarket: MarketOne?
    var cartID: CartID?
    var storeID: StoreElement?
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
struct CartID: Codable {
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
// MARK: - Encode/decode helpers

class MarketModel: ObservableObject {
    @Published var currentMarket: MarketOne? = nil
}
