//
//  MarketReviewJASON.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/19.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let marketReview = try? JSONDecoder().decode(MarketReview.self, from: jsonData)

import Foundation

// MARK: - MarketReviewElement
struct MarketReviewElement: Codable {
    var marketReviewID: Int?
    var mrMarketID: MrMarketID?
    var mrMemberID: JSONNull?
    var ratings: Int?
    var reviewContent, reviewDate, marketReviewFile: JSONNull?

    enum CodingKeys: String, CodingKey {
        case marketReviewID = "marketReviewId"
        case mrMarketID = "mrMarketId"
        case mrMemberID = "mrMemberId"
        case ratings, reviewContent, reviewDate, marketReviewFile
    }
}

// MARK: - MrMarketID
struct MrMarketID: Codable {
    var marketID: Int?
    var marketName, marketAddress1, marketAddress2, marketLocation: String?
    var marketLatitude, marketLongitude, marketRatings: Double?
    var marketInfo, parking, toilet, marketPhonenum: String?
    var marketGiftcard, marketType, updateTime: String?
    var marketFile, marketMap: Market?
    var reviewCount: Int?

    enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case marketName, marketAddress1, marketAddress2, marketLocation, marketLatitude, marketLongitude, marketRatings, marketInfo, parking, toilet, marketPhonenum, marketGiftcard, marketType, updateTime, marketFile, marketMap, reviewCount
    }
}

// MARK: - Market
struct Market: Codable {
    var fileID: Int?
    var originalFileName, uploadFileName, uploadFilePath: String?
    var uploadFileURL: String?

    enum CodingKeys: String, CodingKey {
        case fileID = "fileId"
        case originalFileName, uploadFileName, uploadFilePath
        case uploadFileURL = "uploadFileUrl"
    }
}

typealias MarketReview = [MarketReviewElement]

