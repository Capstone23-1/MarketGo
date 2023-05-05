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

import Foundation

// MARK: - MarketOneElement
struct MarketOneElement: Codable {
    let marketID: Int
    let marketName, marketAddress1, marketAddress2, marketLocation: String
    let marketLatitude, marketLongitude: Double
    let marketRatings: Int
    let marketInfo, parking, toilet, marketPhonenum: String
    let marketGiftcard: String
    let marketFile: MarketFile

    enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case marketName, marketAddress1, marketAddress2, marketLocation, marketLatitude, marketLongitude, marketRatings, marketInfo, parking, toilet, marketPhonenum, marketGiftcard, marketFile
    }
}

// MARK: - MarketFile
struct MarketFile: Codable {
    let fileID: Int
    let originalFileName, uploadFileName, uploadFilePath: String
    let uploadFileURL: String

    enum CodingKeys: String, CodingKey {
        case fileID = "fileId"
        case originalFileName, uploadFileName, uploadFilePath
        case uploadFileURL = "uploadFileUrl"
    }
}

typealias MarketOne = [MarketOneElement]
