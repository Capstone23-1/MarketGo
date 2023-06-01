//
//  GoodsDataJASON.swift
//  MarketGo
//
//  Created by 김주현 on 2023/06/01.
//

import Foundation

// MARK: - GoodsDatum
struct GoodsDatum: Codable {
    var goodsDataID: Int?
    var goodsID, price: Int?
    var updatedDate: String?

    enum CodingKeys: String, CodingKey {
        case goodsDataID = "goodsDataId"
        case goodsID = "goodsId"
        case price, updatedDate
    }
}

typealias GoodsData = [GoodsDatum]

