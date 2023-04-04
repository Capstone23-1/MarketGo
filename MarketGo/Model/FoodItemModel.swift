//
//  FoodItemModel.swift
//  MarketGo
//
//  Created by 김주현 on 2023/03/29.
// 장바구니에 넣을 상품정보

import Foundation

public struct FoodItem: Hashable, Identifiable {
    
    public let id = UUID()
    
    let name: String
    let storeName: String
    let imageName: String
    let price: Int
    var quantity: Int = 1
}

public struct Store: Hashable, Identifiable {
    
    public let id = UUID()
    
    let name: String
    let reviewCnt: Int //리뷰개수
    let address: String
    let storeImage: String
    let products: [FoodItem] //가게에서 파는 물품정보
}
