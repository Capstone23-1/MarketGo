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
    let store_num: Int
    var quantity: Int = 1
}

public struct Store: Hashable, Identifiable {
    
    public let id = UUID()
    
    let store_name: String //가게이름
    let address1: String //주소(도로명주소/지번주소)
    let store_ratings: Double //평점
    let store_phone_num: String //가게 전화번호
    let card_avail: Bool //카드결제 가능여부
    let local_avail: Bool //지역화폐 가능여부
    let reviewCnt: Int //리뷰개수
    let products: [FoodItem] //가게에서 파는 물품정보
    let store_num: Int
    let store_image: String //가게사진
}
