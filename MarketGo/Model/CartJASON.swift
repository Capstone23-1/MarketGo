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
    var goodsId1, goodsId2, goodsId3, goodsId4: GoodsOne?
    var goodsId5, goodsId6, goodsId7, goodsId8: GoodsOne?
    var goodsId9, goodsId10: GoodsOne?
    var unit1, unit2, unit3, unit4: Int?
    var unit5, unit6, unit7, unit8: Int?
    var unit9, unit10: Int?

    enum CodingKeys: String, CodingKey {
        case cartID = "cartId"
        case cartDate, goodsId1, goodsId2, goodsId3, goodsId4, goodsId5, goodsId6, goodsId7, goodsId8, goodsId9, goodsId10, unit1, unit2, unit3, unit4, unit5, unit6, unit7, unit8, unit9, unit10
    }
}



class CartViewModel: ObservableObject {
    @Published var cart: Cart?
    @Published var cartItems: [CartItem] = []
    
    func fetchCart(forUserId cartId: Int) {
        let url = "http://3.34.33.15:8080/cart/\(cartId)"
        
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
    
    private func updateCartItems() {
        guard let cart = self.cart else {
            self.cartItems = []
            return
        }
        
        var items: [CartItem] = []
        
        if let goodsId1 = cart.goodsId1, let unit1 = cart.unit1, goodsId1.goodsID != 0 {
            let cartItem = CartItem(product: goodsId1, count: unit1)
            items.append(cartItem)
        }
        
        if let goodsId2 = cart.goodsId2, let unit2 = cart.unit2, goodsId2.goodsID != 0 {
            let cartItem = CartItem(product: goodsId2, count: unit2)
            items.append(cartItem)
        }
        
        if let goodsId3 = cart.goodsId3, let unit3 = cart.unit3, goodsId3.goodsID != 0 {
            let cartItem = CartItem(product: goodsId3, count: unit3)
            items.append(cartItem)
        }
        
        if let goodsId4 = cart.goodsId4, let unit4 = cart.unit4, goodsId4.goodsID != 0 {
            let cartItem = CartItem(product: goodsId4, count: unit4)
            items.append(cartItem)
        }
        
        if let goodsId5 = cart.goodsId5, let unit5 = cart.unit5, goodsId5.goodsID != 0 {
            let cartItem = CartItem(product: goodsId5, count: unit5)
            items.append(cartItem)
        }
        
        if let goodsId6 = cart.goodsId6, let unit6 = cart.unit6, goodsId6.goodsID != 0 {
            let cartItem = CartItem(product: goodsId6, count: unit6)
            items.append(cartItem)
        }

        if let goodsId7 = cart.goodsId7, let unit7 = cart.unit7, goodsId7.goodsID != 0 {
            let cartItem = CartItem(product: goodsId7, count: unit7)
            items.append(cartItem)
        }

        if let goodsId8 = cart.goodsId8, let unit8 = cart.unit8, goodsId8.goodsID != 0 {
            let cartItem = CartItem(product: goodsId8, count: unit8)
            items.append(cartItem)
        }

        if let goodsId9 = cart.goodsId9, let unit9 = cart.unit9, goodsId9.goodsID != 0 {
            let cartItem = CartItem(product: goodsId9, count: unit9)
            items.append(cartItem)
        }

        if let goodsId10 = cart.goodsId10, let unit10 = cart.unit10, goodsId10.goodsID != 0 {
            let cartItem = CartItem(product: goodsId10, count: unit10)
            items.append(cartItem)
        }

        
        self.cartItems = items
    }

}


// MARK: - GoodsID
struct GoodsID: Codable, Equatable {
    var goodsID: Int?
    var goodsName: String?
    var goodsMarket: MarketOne?
    var goodsStore: StoreElement?
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
