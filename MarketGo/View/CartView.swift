import SwiftUI
import Alamofire


struct CartView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var cart: CartModel

   var body: some View {
       
       List($cart.cartItems) { $cartItem in
           NavigationLink(destination: GoodsCompareView(goodsName: $cartItem.product.goodsName.wrappedValue ?? "")) {
             CartItemRow(cartItem:  $cartItem)
               
           }
       }
       .onAppear{
           cart.fetchCart(forUserId: userModel.currentUser?.cartID?.cartID ?? 0)
       }
       .navigationTitle("장바구니")
       
       TotalPriceView()
}}



struct CartItemRow: View {
    @Binding var cartItem: CartItem
    @EnvironmentObject var cart: CartModel
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
                Text(cartItem.product.goodsName ?? "")
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                Text("\(totalPrice)원").font(.system(size: 12))
                Text("\(cartItem.product.goodsMarket?.marketName ?? "")")
                    .foregroundColor(.gray)
                    .font(.system(size: 9))
                Spacer()
            }
            
            Spacer()
            
            VStack(alignment: .trailing){
                Stepper(value: $cartItem.count, in: 1...Int.max, label: {
                    HStack {
                        Spacer()
                        Text("\(cartItem.count)").font(.system(size: 13))
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
            .buttonStyle(PlainButtonStyle()) // Disable button styling
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
    }
}





struct TotalPriceView: View {
    @EnvironmentObject var cart: CartModel
    
    var totalPrice: Int {
        cart.cartItems.reduce(0) { $0 + ($1.product.goodsPrice ?? 0) * $1.count }
    }
    
    var body: some View {
        HStack {
            Text("총 가격: ")
            Text("\(totalPrice)원")
        }
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
