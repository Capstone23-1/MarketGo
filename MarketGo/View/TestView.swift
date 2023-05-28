//import SwiftUI
//
//struct CartItem: Hashable, Identifiable {
//    let id = UUID()
//    let goodsID: GoodsID?
//    let unit: Int?
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    
//    static func ==(lhs: CartItem, rhs: CartItem) -> Bool {
//        return lhs.id == rhs.id && lhs.goodsID == rhs.goodsID && lhs.unit == rhs.unit
//    }
//}
//
//
//struct CartView: View {
//    @EnvironmentObject var userModel: UserModel
//    @ObservedObject var cartViewModel = CartViewModel()
//    @State private var cartItems: [CartItem] = []
//
//    var body: some View {
//        VStack {
//            List(cartItems) { cartItem in
//                if let goodsName = cartItem.goodsID?.goodsName,
//                   let unit = cartItem.unit {
//                    VStack(alignment: .leading) {
//                        Text(goodsName)
//                            .fontWeight(.semibold)
//                        Text("Unit: \(unit)")
//                            .font(.system(size: 14))
//                        // Add more information about the goods unit if needed
//                    }
//                }
//            }
//            .onAppear {
//                fetchGoodsUnits()
//            }
//        }
//        .navigationBarTitle("장바구니")
//        .onAppear {
//            cartViewModel.fetchCart(forUserId: userModel.currentUser?.cartID?.cartID ?? 0) // Fetch cart using cartId
//        }
//    }
//
//    func fetchGoodsUnits() {
//        guard let cart = cartViewModel.cart else {
//            return
//        }
//
//        let goodsIds: [GoodsID?] = [
//            cart.goodsId1, cart.goodsId2, cart.goodsId3, cart.goodsId4, cart.goodsId5,
//            cart.goodsId6, cart.goodsId7, cart.goodsId8, cart.goodsId9, cart.goodsId10
//        ]
//
//        var units: [CartItem] = []
//        for i in 0..<goodsIds.count {
//            if let goodsID = goodsIds[i],
//               let unit = getUnit(forGoodsID: goodsID) {
//                let cartItem = CartItem(goodsID: goodsID, unit: unit)
//                units.append(cartItem)
//            }
//        }
//
//        cartItems = units
//    }
//
//    func getUnit(forGoodsID goodsID: GoodsID?) -> Int? {
//        switch goodsID {
//        case cartViewModel.cart?.goodsId1:
//            return cartViewModel.cart?.unit1
//        case cartViewModel.cart?.goodsId2:
//            return cartViewModel.cart?.unit2
//        case cartViewModel.cart?.goodsId3:
//            return cartViewModel.cart?.unit3
//        case cartViewModel.cart?.goodsId4:
//            return cartViewModel.cart?.unit4
//        case cartViewModel.cart?.goodsId5:
//            return cartViewModel.cart?.unit5
//        case cartViewModel.cart?.goodsId6:
//            return cartViewModel.cart?.unit6
//        case cartViewModel.cart?.goodsId7:
//            return cartViewModel.cart?.unit7
//        case cartViewModel.cart?.goodsId8:
//            return cartViewModel.cart?.unit8
//        case cartViewModel.cart?.goodsId9:
//            return cartViewModel.cart?.unit9
//        case cartViewModel.cart?.goodsId10:
//            return cartViewModel.cart?.unit10
//        default:
//            return nil
//        }
//    }
//}
