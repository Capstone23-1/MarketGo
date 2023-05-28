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
}}
