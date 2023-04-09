//
//  FoodItemModel.swift
//  MarketGo
//
//  Created by 김주현 on 2023/03/29.
//  상품정보와 가게정보

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

extension FoodItem {
    static let foodItems: [FoodItem] = [
        FoodItem(name: "Apple", storeName: "Store A", imageName: "apple", price: 100, store_num: 1),
        FoodItem(name: "Banana", storeName: "Store A", imageName: "banana", price: 150, store_num: 1),
        FoodItem(name: "Carrot", storeName: "Store A", imageName: "carrot", price: 200, store_num: 1),
        FoodItem(name: "Orange", storeName: "Store B", imageName: "orange", price: 120, store_num: 2),
        FoodItem(name: "Grape", storeName: "Store B", imageName: "grape", price: 300, store_num: 2),
        FoodItem(name: "Watermelon", storeName: "Store C", imageName: "watermelon", price: 1000, store_num: 3),
        FoodItem(name: "Pineapple", storeName: "Store C", imageName: "pineapple", price: 800, store_num: 3),
        FoodItem(name: "Tomato", storeName: "Store D", imageName: "tomato", price: 150, store_num: 4),
        FoodItem(name: "Broccoli", storeName: "Store E", imageName: "broccoli", price: 250, store_num: 5),
        FoodItem(name: "Potato", storeName: "Store E", imageName: "potato", price: 200, store_num: 5),
    ]

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
    let store_image: String//가게사진
}

extension Store{
    
    static let foods: [FoodItem] = FoodItem.foodItems
    
    static let stores: [Store] = [
        Store(store_name: "영찬과일", address1: "123 Main St", store_ratings: 4.5, store_phone_num: "555-555-1234", card_avail: true, local_avail: false, reviewCnt: 10, products: [Self.foods[0], Self.foods[1],Self.foods[2]], store_num: 1, store_image: "영찬과일"),
        Store(store_name: "Store B", address1: "456 Elm St", store_ratings: 4.0, store_phone_num: "555-555-5678", card_avail: false, local_avail: true, reviewCnt: 20, products: [Self.foods[3],Self.foods[4]], store_num: 2, store_image: "소람과일"),
        Store(store_name: "Store C", address1: "789 Maple St", store_ratings: 3.5, store_phone_num: "555-555-9012", card_avail: true, local_avail: true, reviewCnt: 5, products: [], store_num: 3, store_image: "소람과일"),
        Store(store_name: "Store D", address1: "321 Oak St", store_ratings: 3.0, store_phone_num: "555-555-3456", card_avail: false, local_avail: false, reviewCnt: 15, products: [], store_num: 4, store_image: "소람과일"),
        Store(store_name: "Store E", address1: "654 Cedar St", store_ratings: 2.5, store_phone_num: "555-555-7890", card_avail: true, local_avail: false, reviewCnt: 8, products: [], store_num: 5, store_image: "소람과일")
    ]
}

