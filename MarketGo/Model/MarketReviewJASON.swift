import Foundation
import SwiftUI
import Alamofire

/// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let marketReview = try? JSONDecoder().decode(MarketReview.self, from: jsonData)

// MARK: - MarketReviewElement
struct MarketReviewElement: Codable, Identifiable {
    var marketReviewID: Int?
    var mrMarketID: MrMarketID?
    var mrMemberID: MrMemberID?
    var ratings: Int?
    var reviewContent, reviewDate: String?
    var marketReviewFile: Market?

    enum CodingKeys: String, CodingKey {
        case marketReviewID = "marketReviewId"
        case mrMarketID = "mrMarketId"
        case mrMemberID = "mrMemberId"
        case ratings, reviewContent, reviewDate, marketReviewFile
    }
    
    var id: Int? {
        return marketReviewID
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

// MARK: - MrMarketID
struct MrMarketID: Codable {
    var marketID: Int?
    var marketName, marketAddress1, marketAddress2, marketLocation: String?
    var marketLatitude, marketLongitude, marketRatings: Double?
    var marketInfo, parking, toilet, marketPhonenum: String?
    var marketGiftcard: String?
    var marketType, updateTime: String?
    var marketFile, marketMap: Market?
    var reviewCount: Int?

    enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case marketName, marketAddress1, marketAddress2, marketLocation, marketLatitude, marketLongitude, marketRatings, marketInfo, parking, toilet, marketPhonenum, marketGiftcard, marketType, updateTime, marketFile, marketMap, reviewCount
    }
}

// MARK: - MrMemberID
struct MrMemberID: Codable {
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


typealias MarketReview = [MarketReviewElement]

class MarketReviewViewModel: ObservableObject {
    @Published var marketReviews: [MarketReviewElement]?
    @Published var isLoading = false
    
    func fetchMarketReviews(for marketId: Int) {
        isLoading = true
        let urlString = "http://3.34.33.15:8080/marketReview/marketId/\(marketId)"
        
        AF.request(urlString).responseDecodable(of: [MarketReviewElement].self) { response in
            switch response.result {
            case .success(let marketReviews):
                self.marketReviews = marketReviews
            case .failure(let error):
                print("Error fetching market reviews: \(error)")
            }
            
            self.isLoading = false
        }
    }
}



// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
