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

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseMarketOneElement { response in
//     if let marketOneElement = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - MarketOneElement
struct MarketOneElement: Codable {
    var marketID: Int?
    var marketName, marketAddress1, marketAddress2, marketLocation: String?
    var marketLatitude, marketLongitude, marketRatings: Double?
    var marketInfo, parking, toilet, marketPhonenum: String?
    var marketGiftcard, marketType, updateTime: String?
    var marketFile, marketMap: Market?
    var reviewCount: Int?

    enum CodingKeys: String, CodingKey {
        case marketID
        case marketName, marketAddress1, marketAddress2, marketLocation, marketLatitude, marketLongitude, marketRatings, marketInfo, parking, toilet, marketPhonenum, marketGiftcard, marketType, updateTime, marketFile, marketMap, reviewCount
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseMarket { response in
//     if let market = response.result.value {
//       ...
//     }
//   }

// MARK: - Market
struct Market: Codable {
    var fileID: Int?
    var originalFileName, uploadFileName, uploadFilePath: String?
    var uploadFileURL: String?

    enum CodingKeys: String, CodingKey {
        case fileID
        case originalFileName, uploadFileName, uploadFilePath
        case uploadFileURL
    }
}

typealias MarketOne = [MarketOneElement]

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
