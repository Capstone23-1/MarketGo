//struct CartView: View {
//    @EnvironmentObject var userModel: UserModel
//    @ObservedObject var cartViewModel = CartViewModel()
//    @State private var cartItems: [CartItem] = []
//
//    // ... rest of the code
//
//    var body: some View {
//        // ... rest of the code
//
//        VStack {
//            List {
//                ForEach(getGroupedCartItems(), id: \.self) { market in
//                    Section(header: Text(market)) {
//                        ForEach(getCartItems(forMarket: market), id: \.self) { cartItem in
//                            if let index = cartItems.firstIndex(where: { $0.id == cartItem.id }) {
//                                HStack {
//                                    VStack(alignment: .leading) {
//                                        Text(cartItems[index].goodsName) // Use cartItems[index] here
//                                            .fontWeight(.semibold)
//                                        Text("Unit: \(cartItems[index].unit)") // Use cartItems[index] here
//                                            .font(.system(size: 14))
//                                        // Add more information about the cart item if needed
//                                    }
//                                    Spacer()
//                                    Stepper(value: $cartItems[index].quantity, in: 1...10) {
//                                        Text("\(cartItems[index].quantity) 개")
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//
//            // ... rest of the code
//        }
//    }
//
//    // ... rest of the code
//}
