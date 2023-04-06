//
//  APITestModel.swift
//  MarketGo
//
//  Created by ram on 2023/04/06.
//

import Foundation

public struct getModel: Decodable{
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
public struct Comment: Decodable{
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
public struct ParkingLotModel: Decodable{
    var address_name: String
    var distance: String
    var id: String
    var place_name: String
    var place_url: String
    var x: String
    var y: String
}
public struct metaModel: Decodable{
    var is_end: Bool
    var pageable_count: Int
    var total_count: Int
}

