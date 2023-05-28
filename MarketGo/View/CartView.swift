import SwiftUI
import Alamofire


struct CartView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var cart: cart

   var body: some View {

       List($cart.cartItems) { $cartItem in
          NavigationLink(destination: CartItemDetail(cartItem: $cartItem)) {
             CartItemRow(cartItem:  $cartItem)}
       }
       .onAppear{
           cart.fetchCart(forUserId: userModel.currentUser?.cartID?.cartID ?? 0)
       }
}}



struct CartItemRow: View {
   @Binding var cartItem: CartItem
   var body: some View {
   HStack {
       GoodsImage(url: URL(string: cartItem.product.goodsFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo")).frame(width: 100, height: 100).clipShape(Circle())
       
      VStack(alignment: .leading) {
          Text(cartItem.product.goodsName ?? "").fontWeight(.semibold)
          Text("\(cartItem.product.goodsPrice ?? 0) | \(cartItem.product.goodsMarket?.marketName ?? "") | \(cartItem.product.goodsStore?.storeName ?? "")")
         Button("Show details"){}.foregroundColor(.gray)
      }
      Spacer()
      Text("\(cartItem.count)")
   }
}}


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
