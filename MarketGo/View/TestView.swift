import SwiftUI

struct CartView: View {
    @ObservedObject var cartViewModel: CartViewModel = CartViewModel()
    
    var body: some View {
        VStack {
            if let cart = cartViewModel.cart {
                Text("Cart ID: \(cart.cartID ?? 0)")
                Text("Cart Date: \(cart.cartDate ?? "")")
                
                ForEach(1...10, id: \.self) { index in
                    if let goodsId = getGoodsId(for: index, from: cart) {
                        Text("Goods ID \(index): \(goodsId.goodsID ?? 0)")
                        Text("Goods Name \(index): \(goodsId.goodsName ?? "")")
                        // Display other properties as needed
                    }
                }
            } else {
                Text("Cart is empty")
            }
        }
        .onAppear {
            cartViewModel.fetchCart(forUserId: 11) // Replace 11 with the actual user ID
        }
    }
    
    private func getGoodsId(for index: Int, from cart: Cart) -> GoodsID? {
        switch index {
        case 1: return cart.goodsId1
        case 2: return cart.goodsId2
        case 3: return cart.goodsId3
        case 4: return cart.goodsId4
        case 5: return cart.goodsId5
        case 6: return cart.goodsId6
        case 7: return cart.goodsId7
        case 8: return cart.goodsId8
        case 9: return cart.goodsId9
        case 10: return cart.goodsId10
        default: return nil
        }
    }
}

