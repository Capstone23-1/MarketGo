//
//  ClovaOcrModel.swift
//  MarketGo
//
//  Created by ram on 2023/06/22.
//

import Foundation

struct Response: Codable {
    let version, requestID: String
    let timestamp: Int
    let images: [OcrImage]

    enum CodingKeys: String, CodingKey {
        case version
        case requestID = "requestId"
        case timestamp, images
    }
}

struct OcrImage: Codable {
    let uid, name, inferResult, message: String
    let validationResult: ValidationResult
    let convertedImageInfo: ConvertedImageInfo
    let fields: [OcrField]
}

struct ConvertedImageInfo: Codable {
    let width, height, pageIndex: Int
    let longImage: Bool
}

struct OcrField: Codable {
    let valueType: String
    let boundingPoly: BoundingPoly
    let inferText: String
    let inferConfidence: Double
    let type: String
    let lineBreak: Bool
}

struct BoundingPoly: Codable {
    let vertices: [Vertex]
}

struct Vertex: Codable {
    let x, y: Int
}

struct ValidationResult: Codable {
    let result: String
}
