import Foundation
import Alamofire

// MARK: - StoreReviewPost
struct StoreReviewPost: Codable {
    var storeId, memberId: Int
    var ratings: Double
    var reviewContent: String
    var storeReviewFile: Int

    enum CodingKeys: String, CodingKey {
        case storeId
        case memberId
        case ratings
        case reviewContent
        case storeReviewFile
    }
}
