//
//  LocationModel.swift
//  MarketGo
//
//  Created by ram on 2023/04/04.
//

import Foundation

public struct CoordinateInfo{
    var lat: Double //경도
    var lng: Double //위도
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
        print("lat: \(self.lat), lng: \(self.lng)")
    }
    
}
