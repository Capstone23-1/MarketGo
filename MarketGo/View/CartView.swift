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


