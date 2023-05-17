//
//  CartView.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import SwiftUI
struct CartItem: Identifiable {
    let id: UUID = UUID()
    let goodsName: String
    let unit: Int
}


struct CartView: View {
    @EnvironmentObject var userModel: UserModel
    @ObservedObject var cartViewModel = CartViewModel()
    
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
                    if let goodsName = goodsId?.goodsName, let unit = goodsId?.goodsUnit {
                        let cartItem = CartItem(goodsName: goodsName, unit: Int(unit) ?? 0)
                        cartItems.append(cartItem)
                    }
                }
            }

            return cartItems
        }


    var body: some View {
        VStack {
            List {
                ForEach(getGroupedCartItems(), id: \.self) { market in
                    Section(header: Text(market)) {
                        ForEach(getCartItems(forMarket: market), id: \.self) { cartItem in
                            HStack {
                                // Display the cart item information
                            }
                        }
                    }
                }
            }
            Spacer()
            HStack {
                // Display the total price
            }
        }
        .navigationBarTitle("장바구니")
        .navigationBarItems(trailing: EditButton())
        .onAppear {
            cartViewModel.fetchCart(forUserId: userModel.currentUser?.cartID)
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
            if let marketName = goodsId?.goodsMarket?.name, !marketNames.contains(marketName) {
                marketNames.append(marketName)
            }
        }

        return marketNames
    }

    // Get the cart items for a specific market
    func getCartItems(forMarket market: String) -> [Good] {
        guard let cart = cartViewModel.cart else {
            return []
        }

        var cartItems: [CartItem] = []
        let goodsIds: [GoodsID?] = [
            cart.goodsId1, cart.goodsId2, cart.goodsId3, cart.goodsId4, cart.goodsId5,
            cart.goodsId6, cart.goodsId7, cart.goodsId8, cart.goodsId9, cart.goodsId10
        ]

        for goodsId in goodsIds {
            if let marketName = goodsId?.goodsMarket?.name, marketName == market {
                let cartItem = // Create a CartItem object from the goodsId and unit information
                cartItems.append(cartItem)
            }
        }

        return cartItems
    }

    // Get the cart items grouped by market name
    func getGroupedCartItems() -> [String] {
        let marketNames = getMarketNames()
        return marketNames.sorted()
    }
}


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
