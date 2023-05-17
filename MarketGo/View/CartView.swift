//
//  CartView.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import SwiftUI
struct CartItem: Identifiable, Hashable {
    let id: UUID = UUID()
    let goodsName: String
    let unit: String
    var quantity: Int
}

struct CartView: View {
    @EnvironmentObject var userModel: UserModel
    @ObservedObject var cartViewModel = CartViewModel()
    @State private var cartItems: [CartItem] = []

    
    var body: some View {
        VStack {
            List {
                ForEach(getGroupedCartItems(), id: \.self) { market in
                    Section(header: Text(market)) {
                        ForEach(getCartItems(forMarket: market), id: \.self) { cartItem in
                            if let index = cartItems.firstIndex(where: { $0.id == cartItem.id }) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(cartItems[index].goodsName) // Use cartItems[index] here
                                            .fontWeight(.semibold)
                                        Text("Unit: \(cartItems[index].unit)") // Use cartItems[index] here
                                            .font(.system(size: 14))
                                        // Add more information about the cart item if needed
                                    }
                                    Spacer()
                                    Stepper(value: $cartItems[index].quantity, in: 1...10) {
                                        Text("\(cartItems[index].quantity) 개")
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // ... rest of the code
        }
        .navigationBarTitle("장바구니")
        .navigationBarItems(trailing: EditButton())
        .onAppear {
            cartViewModel.fetchCart(forUserId: userModel.currentUser?.memberID ?? 0)
        }
    }

    // Get the unique market names from the cart items
    func getMarketNames() -> [String] {
        guard let cart = cartViewModel.cart else {
            return []
        }

        var marketNames: [String] = []
        let goodsIds: [GoodsID?] = [
            cart.goodsId1, cart.goodsId2, cart.goodsId3, cart.goodsId4, cart.goodsId5,
            cart.goodsId6, cart.goodsId7, cart.goodsId8, cart.goodsId9, cart.goodsId10
        ]

        for goodsId in goodsIds {
            if let marketName = goodsId?.goodsMarket?.marketName, !marketNames.contains(marketName) {
                marketNames.append(marketName)
            }
        }

        return marketNames
    }

    // Get the cart items for a specific market
    func getCartItems(forMarket market: String) -> [CartItem] {
        guard let cart = cartViewModel.cart else {
            return []
        }

        var cartItems: [CartItem] = []
        let goodsIds: [GoodsID?] = [
            cart.goodsId1, cart.goodsId2, cart.goodsId3, cart.goodsId4, cart.goodsId5,
            cart.goodsId6, cart.goodsId7, cart.goodsId8, cart.goodsId9, cart.goodsId10
        ]

        for goodsId in goodsIds {
            if let marketName = goodsId?.goodsMarket?.marketName, marketName == market {
                if let goodsName = goodsId?.goodsName,
                   let unit = getUnit(forGoodsId: goodsId),
                   let quantity = getQuantity(forGoodsId: goodsId) {
                   let cartItem = CartItem(goodsName: goodsName, unit: unit, quantity: quantity)
                    cartItems.append(cartItem)
                }
            }
        }

        return cartItems
    }

    // Get the unit information for a specific GoodsID
    func getUnit(forGoodsId goodsId: GoodsID?) -> String? {
        return goodsId?.goodsUnit
    }
    
    // Get the quantity for a specific GoodsID
    func getQuantity(forGoodsId goodsId: GoodsID?) -> Int? {
        guard let cart = cartViewModel.cart else {
            return nil
            }
        switch goodsId {
        case cart.goodsId1:
            return cart.unit1
        case cart.goodsId2:
            return cart.unit2
        case cart.goodsId3:
            return cart.unit3
        case cart.goodsId4:
            return cart.unit4
        case cart.goodsId5:
            return cart.unit5
        case cart.goodsId6:
            return cart.unit6
        case cart.goodsId7:
            return cart.unit7
        case cart.goodsId8:
            return cart.unit8
        case cart.goodsId9:
            return cart.unit9
        case cart.goodsId10:
            return cart.unit10
        default:
            return nil
        }
    }

    // Get the cart items grouped by market name
    func getGroupedCartItems() -> [String] {
        let marketNames = getMarketNames()
        return marketNames.sorted()
    }

    // Calculate the total price of all cart items
    func calculateTotalPrice() -> Int {
        guard let cart = cartViewModel.cart else {
            return 0
        }
        
        var totalPrice = 0
        let goodsIds: [GoodsID?] = [
            cart.goodsId1, cart.goodsId2, cart.goodsId3, cart.goodsId4, cart.goodsId5,
            cart.goodsId6, cart.goodsId7, cart.goodsId8, cart.goodsId9, cart.goodsId10
        ]
        
        for goodsId in goodsIds {
            if let price = goodsId?.goodsPrice, let quantity = getQuantity(forGoodsId: goodsId) {
                totalPrice += price * quantity
            }
        }
        
        return totalPrice
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(UserModel())
    }
}
