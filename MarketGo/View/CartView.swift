import SwiftUI

struct CartItem: Identifiable {
    var id: UUID
    var product: GoodsOne
    var count: Int
    
    init(product: GoodsOne, count: Int) {
        self.id = UUID()
        self.product = product
        self.count = count
    }
}

class cart: ObservableObject {
   @Published var cartItems: [CartItem]
   init() {
      self.cartItems = []
   }
    
    func addProduct(product: GoodsOne){
       var addNewProduct = true
       for (index, item) in cartItems.enumerated() {
          if item.product.id == product.id {
             cartItems[index].count = cartItems[index].count + 1
             addNewProduct = false
          }
       }
       if addNewProduct {
          cartItems.append(CartItem(product: product, count: 1))
       }
    }
}


struct CartView: View {
   @EnvironmentObject var cart: cart
   var body: some View {
   NavigationView {
      List($cart.cartItems) { $cartItem in
         NavigationLink(destination: CartItemDetail(cartItem: $cartItem)) {
            CartItemRow(cartItem:  $cartItem)}
      }.navigationTitle("Cart")
   }.navigationViewStyle(StackNavigationViewStyle())
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
