import SwiftUI

//struct CartView: View {
//    @ObservedObject var cartViewModel: CartViewModel = CartViewModel()
//    @EnvironmentObject var userModel: UserModel
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                if let cart = cartViewModel.cart {
//                    List {
//                        Section(header: Text("Cart Information")) {
//                            Text("Cart ID: \(cart.cartID ?? 0)")
//                            Text("Cart Date: \(cart.cartDate ?? "")")
//                        }
//
//                        Section(header: Text("Goods")) {
//                            ForEach(getGoodsAndUnits(from: cart)) { goodsUnit in
//
//                                HStack {
//                                    Text("Goods ID: \(goodsUnit.goodsID)")
//                                    Spacer()
//                                    Text("Goods Name: \(goodsUnit.goodsName ?? "")")
//                                    Spacer()
//                                    Text("Unit: \(goodsUnit.unit ?? 0)")
//                                    Spacer()
//                                    Text("Price: \(goodsUnit.price ?? 0)")
//                                }
//                            }
//                        }
//                    }
//                } else {
//                    Text("Cart is empty")
//                }
//            }
//            .navigationBarTitle("Cart")
//            .onAppear {
//                cartViewModel.fetchCart(forUserId: userModel.currentUser?.cartID?.cartID ?? 0) // Replace 11 with the actual user ID
//            }
//        }
//    }
//
//    private func getGoodsAndUnits(from cart: Cart) -> [GoodsUnit] {
//        var goodsAndUnits: [GoodsUnit] = []
//
//        if let goodsId1 = cart.goodsId1, let unit1 = cart.unit1, goodsId1.goodsID != 0 {
//            let goodsUnit = GoodsUnit(goodsID: goodsId1.goodsID ?? 0,
//                                      unit: unit1,
//                                      goodsName: goodsId1.goodsName,
//                                      price: goodsId1.goodsPrice)
//            goodsAndUnits.append(goodsUnit)
//        }
//
//        if let goodsId2 = cart.goodsId2, let unit2 = cart.unit2, goodsId2.goodsID != 0 {
//            let goodsUnit = GoodsUnit(goodsID: goodsId2.goodsID ?? 0,
//                                      unit: unit2,
//                                      goodsName: goodsId2.goodsName,
//                                      price: goodsId2.goodsPrice)
//            goodsAndUnits.append(goodsUnit)
//        }
//
//        if let goodsId3 = cart.goodsId3, let unit3 = cart.unit3, goodsId3.goodsID != 0 {
//            let goodsUnit = GoodsUnit(goodsID: goodsId3.goodsID ?? 0,
//                                      unit: unit3,
//                                      goodsName: goodsId3.goodsName,
//                                      price: goodsId3.goodsPrice)
//            goodsAndUnits.append(goodsUnit)
//        }
//
//        if let goodsId4 = cart.goodsId3, let unit4 = cart.unit4, goodsId4.goodsID != 0 {
//            let goodsUnit = GoodsUnit(goodsID: goodsId4.goodsID ?? 0,
//                                      unit: unit4,
//                                      goodsName: goodsId4.goodsName,
//                                      price: goodsId4.goodsPrice)
//            goodsAndUnits.append(goodsUnit)
//        }
//
//        if let goodsId5 = cart.goodsId5, let unit5 = cart.unit5, goodsId5.goodsID != 0 {
//            let goodsUnit = GoodsUnit(goodsID: goodsId5.goodsID ?? 0,
//                                      unit: unit5,
//                                      goodsName: goodsId5.goodsName,
//                                      price: goodsId5.goodsPrice)
//            goodsAndUnits.append(goodsUnit)
//        }
//
//
//
//        return goodsAndUnits
//    }
//}
