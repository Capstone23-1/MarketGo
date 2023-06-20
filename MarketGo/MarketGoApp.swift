import SwiftUI
import FirebaseCore

@main
struct MarketGoApp: App {
    @StateObject var userModel = UserModel()
    @StateObject private var storePost = StorePostViewModel()
    @Environment(\.scenePhase) var scenePhase
    @StateObject var cart = CartModel()
    

    var body: some Scene {
        WindowGroup {
            NavigationView {
                
                    SignInView()
                        .environmentObject(userModel)
                        .environmentObject(storePost)
                        .environmentObject(cart)
                    
                
                
            }
        }
    }
}
