import SwiftUI
import Alamofire


struct CartView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var cart: cart

    var groupedCartItems: [String: [CartItem]] {
        let initial: [String: [CartItem]] = [:]
        return Dictionary(grouping: cart.cartItems, by: { $0.product.goodsMarket?.marketName ?? ""})
    }

    var body: some View {
        List {
            ForEach(groupedCartItems.keys.sorted(), id: \.self) { key in
                Section(header: Text(key)) {
                    ForEach(groupedCartItems[key] ?? [], id: \.product.goodsID) { cartItem in
                        NavigationLink(destination: FoodItemDetailView(goods: cartItem.product)) {
                            CartItemRow(cartItem:  .constant(cartItem))
                        }
                    }
                    Text("시장 내 총액: \(calculateTotalPrice(items: groupedCartItems[key] ?? []))원")
                        .font(.footnote)
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .onAppear{
            cart.fetchCart(forUserId: userModel.currentUser?.cartID?.cartID ?? 0)
        }
        .navigationTitle("장바구니")
        TotalPriceView()
    }

    private func calculateTotalPrice(items: [CartItem]) -> Int {
        items.reduce(0) { $0 + ($1.product.goodsPrice ?? 0) * $1.count }
    }
}




struct CartItemRow: View {
    @Binding var cartItem: CartItem
    @EnvironmentObject var cart: cart
    @EnvironmentObject var userModel: UserModel
    
    @State private var showingConfirmationAlert = false
    
    var totalPrice: Int {
        (cartItem.product.goodsPrice ?? 0) * cartItem.count
    }
    
    var body: some View {
        HStack {
            GoodsImage(url: URL(string: cartItem.product.goodsFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo"))
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Spacer()
                Text("\((cartItem.product.goodsStore?.storeName)! ?? "")")
                    .foregroundColor(.gray)
                    .font(.footnote)
                Text(cartItem.product.goodsName ?? "")
                    .fontWeight(.semibold)
                    .font(.footnote)
                Text("\(totalPrice)원").font(.footnote)
                
                Spacer()
            }
            
            Spacer()
            
            VStack(alignment: .trailing){
                Stepper(value: $cartItem.count, in: 1...Int.max, label: {
                    HStack {
                        Spacer()
                        Text("\(cartItem.count)").font(.system(size: 15))
                    }
                })
                .onChange(of: cartItem.count) { newValue in
                    cart.updateCartItemsOnServer(cartId: userModel.currentUser?.cartID?.cartID ?? 0)
                }
                
                Text("\(cartItem.product.goodsPrice ?? 0)원 (단위: \(cartItem.product.goodsUnit ?? "개"))").font(.system(size: 10))
            }
            
            Button(action: {
                showingConfirmationAlert = true
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
//            .buttonStyle(PlainButtonStyle()) // Disable button styling
            .alert(isPresented: $showingConfirmationAlert) {
                Alert(
                    title: Text("삭제 확인"),
                    message: Text("정말로 이 항목을 삭제하시겠습니까?"),
                    primaryButton: .destructive(Text("삭제"), action: {
                        cart.removeProduct(productID: cartItem.product.goodsID ?? 0)
                    }),
                    secondaryButton: .cancel(Text("취소"))
                )
            }

        }
        .frame(minHeight: 70)
    }
}





struct TotalPriceView: View {
    @EnvironmentObject var cart: cart
    @State var move1 = false
    var totalPrice: Int {
        cart.cartItems.reduce(0) { $0 + ($1.product.goodsPrice ?? 0) * $1.count }
    }
    
    var body: some View {
        Button(action: {
            move1 = true
        }, label: {
            Text("총 가격 \(totalPrice)원")
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                
                
        })
        .padding([.leading, .bottom, .trailing],10)
        
        
    }
}



struct CartItemDetail: View {
   @Binding var cartItem: CartItem
    
   var body: some View {
       
   VStack {
       
       Text(cartItem.product.goodsName ?? "").font(.largeTitle)
       
       GoodsImage(url: URL(string: cartItem.product.goodsFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo")).frame(width: 200, height: 200).clipShape(Circle())
       
       Text("\(cartItem.product.goodsPrice ?? 0) | \(cartItem.product.goodsMarket?.marketName ?? "")")
       
       Text(cartItem.product.goodsInfo ?? "")
           .multilineTextAlignment(.center).padding(.all, 20.0)
   }
}}

