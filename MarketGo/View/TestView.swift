import SwiftUI


struct CartView: View {
    @EnvironmentObject var userModel: UserModel
    @ObservedObject var cartViewModel: CartViewModel = CartViewModel()
    
    var body: some View {
        VStack {
            if let cart = cartViewModel.cart {
                Text("Cart ID: \(cart.cartID ?? 0)")
                Text("Cart Date: \(cart.cartDate ?? "")")
                
                ForEach(1...10, id: \.self) { index in
                    if let goodsId = getNonZeroGoodsId(for: index, from: cart) {
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
            cartViewModel.fetchCart(forUserId: userModel.currentUser?.memberID ?? 0) // Replace 11 with the actual user ID
        }
    }
    
    private func getNonZeroGoodsId(for index: Int, from cart: Cart) -> GoodsID? {
        switch index {
        case 1:
            if let goodsId = cart.goodsId1, goodsId.goodsID != 0 {
                return goodsId
            }
        case 2:
            if let goodsId = cart.goodsId2, goodsId.goodsID != 0 {
                return goodsId
            }
        case 3:
            if let goodsId = cart.goodsId3, goodsId.goodsID != 0 {
                return goodsId
            }
        case 4:
            if let goodsId = cart.goodsId4, goodsId.goodsID != 0 {
                return goodsId
            }
        case 5:
            if let goodsId = cart.goodsId5, goodsId.goodsID != 0 {
                return goodsId
            }
        case 6:
            if let goodsId = cart.goodsId6, goodsId.goodsID != 0 {
                return goodsId
            }
        case 7:
            if let goodsId = cart.goodsId7, goodsId.goodsID != 0 {
                return goodsId
            }
        case 8:
            if let goodsId = cart.goodsId8, goodsId.goodsID != 0 {
                return goodsId
            }
        case 9:
            if let goodsId = cart.goodsId9, goodsId.goodsID != 0 {
                return goodsId
            }
        case 10:
            if let goodsId = cart.goodsId10, goodsId.goodsID != 0 {
                return goodsId
            }
        default:
            return nil
        }
        
        return nil
    }
}
