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
struct MarketJSONData: Codable{
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

