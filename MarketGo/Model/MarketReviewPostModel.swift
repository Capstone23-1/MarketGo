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
import Alamofire

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


class MarketReviewPostViewModel: ObservableObject {
    func submitMarketReview(reviewPost: MarketReviewPost, completion: @escaping (Result<Void, Error>) -> Void) {
        let apiUrl = "http://3.34.33.15:8080/marketReview"

        AF.request(apiUrl, method: .post, parameters: reviewPost, encoder: JSONParameterEncoder.default)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

