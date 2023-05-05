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


