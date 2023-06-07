// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let storeReview = try? JSONDecoder().decode(StoreReview.self, from: jsonData)

import Foundation

// MARK: - StoreReviewElement
struct StoreReviewElement: Codable, Identifiable {
    var storeReviewID: Int?
    var storeID: StoreElement?
    var memberID: MrMemberID?
    var ratings: Int?
    var reviewContent, reviewDate: String?
    var storeReviewFile: StoreReviewFile?

    enum CodingKeys: String, CodingKey {
        case storeReviewID = "storeReviewId"
        case storeID = "storeId"
        case memberID = "memberId"
        case ratings, reviewContent, reviewDate, storeReviewFile
    }
    
    var id: Int?{
        return storeReviewID
    }
}


// MARK: - InterestMarket
struct InterestMarket: Codable {
    var marketID: Int?
    var marketName, marketAddress1, marketAddress2, marketLocation: String?
    var marketLatitude, marketLongitude, marketRatings: Double?
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

// MARK: - StoreCategory
struct StoreCategory2: Codable {
    var categoryID: Int?
    var categoryName: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName
    }
}

typealias StoreReview = [StoreReviewElement]
