import SwiftUI

struct CartView: View {
    @ObservedObject var cartViewModel: CartViewModel = CartViewModel()
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        NavigationView {
            VStack {
                if let cart = cartViewModel.cart {
                    List {
                        Section(header: Text("Cart Information")) {
                            Text("Cart ID: \(cart.cartID ?? 0)")
                            Text("Cart Date: \(cart.cartDate ?? "")")
                        }
                        
                        Section(header: Text("Goods")) {
                            ForEach(1...10, id: \.self) { index in
                                if let goodsId = getGoodsId(for: index, from: cart), goodsId.goodsID != 0 {
                                    HStack {
                                        Text("Goods ID \(index): \(goodsId.goodsID ?? 0)")
                                        Spacer()
                                        Text("Goods Name \(index): \(goodsId.goodsName ?? "")")
                                    }
                                }
                            }
                        }
                    }
                } else {
                    Text("Cart is empty")
                }
            }
            .navigationBarTitle("Cart")
            .onAppear {
                cartViewModel.fetchCart(forUserId: userModel.currentUser?.cartID?.cartID ?? 0) // Replace 11 with the actual user ID
            }
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
