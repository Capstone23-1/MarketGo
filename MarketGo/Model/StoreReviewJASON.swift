// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let storeReview = try? JSONDecoder().decode(StoreReview.self, from: jsonData)

import Foundation

// MARK: - StoreReviewElement
struct StoreReviewElement: Codable, Identifiable {
    
    var id: Int?
    var storeReviewID: Int?
    var storeID: StoreID?
    var memberID: MemberID?
    var ratings: Int?
    var reviewContent, reviewDate: String?
    var storeReviewFile: StoreReviewFile?

    enum CodingKeys: String, CodingKey {
        case storeReviewID = "storeReviewId"
        case storeID = "storeId"
        case memberID = "memberId"
        case ratings, reviewContent, reviewDate, storeReviewFile
    }
}

// MARK: - MemberID
struct MemberID: Codable {
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
    var marketLatitude, marketLongitude: Double?
    var marketRatings: Int?
    var marketInfo, parking, toilet, marketPhonenum: String?
    var marketGiftcard: String?
    var marketType, updateTime: String?
    var marketFile, marketMap: StoreReviewFile?
    var reviewCount: Int?

    enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case marketName, marketAddress1, marketAddress2, marketLocation, marketLatitude, marketLongitude, marketRatings, marketInfo, parking, toilet, marketPhonenum, marketGiftcard, marketType, updateTime, marketFile, marketMap, reviewCount
    }
}

// MARK: - StoreReviewFile
struct StoreReviewFile: Codable {
    var fileID: Int?
    var originalFileName, uploadFileName, uploadFilePath: String?
    var uploadFileURL: String?

    enum CodingKeys: String, CodingKey {
        case fileID = "fileId"
        case originalFileName, uploadFileName, uploadFilePath
        case uploadFileURL = "uploadFileUrl"
    }
}

// MARK: - StoreID
struct StoreID: Codable {
    var storeID: Int?
    var storeName, storeAddress1, storeAddress2: String?
    var storeCategory: StoreCategory?
    var storeRatings: Double?
    var storePhonenum, storeInfo, cardAvail, localAvail: String?
    var storeNum: Int?
    var storeMarketID: InterestMarket?
    var storeFile: StoreReviewFile?
    var reviewCount: Int?

    enum CodingKeys: String, CodingKey {
        case storeID = "storeId"
        case storeName, storeAddress1, storeAddress2, storeCategory, storeRatings, storePhonenum, storeInfo, cardAvail, localAvail, storeNum
        case storeMarketID = "storeMarketId"
        case storeFile, reviewCount
    }
}

// MARK: - StoreCategory
struct StoreCategory: Codable {
    var categoryID: Int
    var categoryName: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName
    }
}

typealias StoreReview = [StoreReviewElement]
