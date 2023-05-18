//
//  CartJASON.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/15.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cart = try? JSONDecoder().decode(Cart.self, from: jsonData)

import Foundation
import Alamofire

// MARK: - Cart
struct Cart: Codable {
    var cartID: Int?
    var cartDate: String?
    var goodsId1, goodsId2, goodsId3, goodsId4: GoodsID?
    var goodsId5, goodsId6, goodsId7, goodsId8: GoodsID?
    var goodsId9, goodsId10: GoodsID?
    var unit1, unit2, unit3, unit4: Int?
    var unit5, unit6, unit7, unit8: Int?
    var unit9, unit10: Int?

    enum CodingKeys: String, CodingKey {
        case cartID = "cartId"
        case cartDate, goodsId1, goodsId2, goodsId3, goodsId4, goodsId5, goodsId6, goodsId7, goodsId8, goodsId9, goodsId10, unit1, unit2, unit3, unit4, unit5, unit6, unit7, unit8, unit9, unit10
    }
}

// MARK: - GoodsID
struct GoodsID: Codable, Equatable {
    var goodsID: Int?
    var goodsName: String?
    var goodsMarket: GoodsMarket?
    var goodsStore: GoodsStore?
    var goodsFile: FileInfo?
    var goodsPrice: Int?
    var goodsUnit, goodsInfo, updateTime, goodsOrigin: String?
    var isAvail: Int?

    enum CodingKeys: String, CodingKey {
        case goodsID = "goodsId"
        case goodsName, goodsMarket, goodsStore, goodsFile, goodsPrice, goodsUnit, goodsInfo, updateTime, goodsOrigin, isAvail
    }
    
    static func ==(lhs: GoodsID, rhs: GoodsID) -> Bool {
            // Implement the equality comparison logic for GoodsID
            // Compare the relevant properties to determine equality
            return lhs.goodsID == rhs.goodsID
        }
}

class CartViewModel: ObservableObject {
    @Published var cart: Cart?
    
    func fetchCart(forUserId userId: Int) {
        let url = "http://3.34.33.15:8080/cart/\(userId)"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let cart = try decoder.decode(Cart.self, from: data)
                    DispatchQueue.main.async {
                        self.cart = cart
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

