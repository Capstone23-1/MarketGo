//
//  MarketReviewPostModel.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let marketReviewPost = try? JSONDecoder().decode(MarketReviewPost.self, from: jsonData)

import Foundation

// MARK: - MarketReviewPost
struct MarketReviewPost: Codable {
    var mrMarketID, mrMemberID: Int
    var ratings: Double
    var reviewContent: String
    var marketReviewFile: Int

    enum CodingKeys: String, CodingKey {
        case mrMarketID = "marketId"
        case mrMemberID = "memberId"
        case ratings, reviewContent, marketReviewFile
    }
}
