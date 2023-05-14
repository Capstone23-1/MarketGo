//
//  MarketJSONData.swift
//  MarketGo
//
//  Created by ram on 2023/04/30.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let MarketJSONData = try? JSONDecoder().decode(MarketJSONData.self, from: jsonData)

import Foundation

// MARK: - MarketJSONData
struct MarketAPIModel: Codable{
    let documents: [Document]
    let meta: Meta
}
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let market = try? JSONDecoder().decode(Market.self, from: jsonData)


// MARK: - ParkingLotJSONData
struct ParkingLotJSONData: Codable{
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable,Hashable,Identifiable{
    
    let distance, id, phone, placeName: String
    let placeURL: String
    let roadAddressName, x, y: String
    
    enum CodingKeys: String, CodingKey {
        
        case distance, id, phone
        case placeName = "place_name"
        case placeURL = "place_url"
        case roadAddressName = "road_address_name"
        case x, y
    }
}


// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount: Int
    let sameName: SameName
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case sameName = "same_name"
        case totalCount = "total_count"
    }
}

// MARK: - SameName
struct SameName: Codable {
    //let keyword: CategoryGroupName
    let region: [JSONAny]
    let selectedRegion: String
    
    enum CodingKeys: String, CodingKey {
        case region
        case selectedRegion = "selected_region"
    }
}
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let storeInfo = try? JSONDecoder().decode(StoreInfo.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseStoreInfo { response in
//     if let storeInfo = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - StoreInfo
struct StoreInfo: Codable {
    var storeID: Int?
    var storeName, storeAddress1, storeAddress2: String?
    var storeCategory: StoreCategory?
    var storeRatings: Double?
    var storePhonenum, storeInfo, cardAvail, localAvail: String?
    var storeNum: Int?
    var storeMarketOne: MarketOne?
    var storeFile: StoreFile?
    var reviewCount: JSONNull?

    enum CodingKeys: String, CodingKey {
        case storeID
        case storeName, storeAddress1, storeAddress2, storeCategory, storeRatings, storePhonenum, storeInfo, cardAvail, localAvail, storeNum
        case storeMarketOne
        case storeFile, reviewCount
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseStoreCategory { response in
//     if let storeCategory = response.result.value {
//       ...
//     }
//   }



//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseStoreFile { response in
//     if let storeFile = response.result.value {
//       ...
//     }
//   }

// MARK: - StoreFile
struct StoreFile: Codable {
    var fileID: Int?
    var originalFileName, uploadFileName, uploadFilePath: String?
    var uploadFileURL: String?

    enum CodingKeys: String, CodingKey {
        case fileID = "fileId"
        case originalFileName, uploadFileName, uploadFilePath
        case uploadFileURL = "uploadFileUrl"
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseStoreMarketID { response in
//     if let storeMarketID = response.result.value {
//       ...
//     }
//   }

//// MARK: - StoreMarketID
//struct StoreMarketID: Codable {
//    var marketID: Int?
//    var marketName, marketAddress1, marketAddress2, marketLocation: String?
//    var marketLatitude, marketLongitude, marketRatings: Double?
//    var marketInfo, parking, toilet, marketPhonenum: String?
//    var marketGiftcard, marketType, updateTime: String?
//    var marketFile, marketMap: StoreFile?
//    var reviewCount: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case marketID
//        case marketName, marketAddress1, marketAddress2, marketLocation, marketLatitude, marketLongitude, marketRatings, marketInfo, parking, toilet, marketPhonenum, marketGiftcard, marketType, updateTime, marketFile, marketMap, reviewCount
//    }
//}
