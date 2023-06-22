//
//  NerModel.swift
//  MarketGo
//
//  Created by ram on 2023/06/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let nerModel = try? JSONDecoder().decode(NerModel.self, from: jsonData)

import Foundation

// MARK: - NerModel
struct NerModel: Codable {
    var id: Int?
    var imageName, text1, text2, text3: String?
}
