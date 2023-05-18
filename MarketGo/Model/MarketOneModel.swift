//
//  MarketOneModel.swift
//  MarketGo
//
//  Created by ram on 2023/05/06.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let marketOne = try? JSONDecoder().decode(MarketOne.self, from: jsonData)
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let marketOne = try? JSONDecoder().decode(MarketOne.self, from: jsonData)

import Foundation

// MARK: - MarketOneElement
struct MarketOne: Codable {
    var marketID: Int=0
    var marketName, marketAddress1, marketAddress2, marketLocation: String?
    var marketLatitude, marketLongitude: Double?
    var marketRatings: Double?
    var marketInfo, parking, toilet, marketPhonenum: String?
    var marketGiftcard, marketType, updateTime: String?
    var marketFile, marketMap: FileInfo?
    var reviewCount: Int?

    enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case marketName, marketAddress1, marketAddress2, marketLocation, marketLatitude, marketLongitude, marketRatings, marketInfo, parking, toilet, marketPhonenum, marketGiftcard, marketType, updateTime, marketFile, marketMap, reviewCount
    }
}

//// MARK: - Market 중복으로 다른걸로 대체
//struct Market: Codable {
//    var fileID: Int?
//    var originalFileName, uploadFileName, uploadFilePath: String?
//    var uploadFileURL: String?
//
//    enum CodingKeys: String, CodingKey {
//        case fileID = "fileId"
//        case originalFileName, uploadFileName, uploadFilePath
//        case uploadFileURL = "uploadFileUrl"
//    }
//}

typealias MarketArray = [MarketOne]
