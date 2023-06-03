import SwiftUI
import FirebaseCore

@main
struct MarketGoApp: App {
    @StateObject var userModel = UserModel()
    @StateObject private var storePost = StorePostViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
    @StateObject var cart = CartModel()
    @State private var deepLinkStoreId: String?
    @State private var fetchedStore: StoreElement?
    @State private var isLoading = false
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack {
                    if isLoading {
                        ProgressView("Loading...")
                    } else if let store = fetchedStore {
                        NavigationLink(destination: StoreView(store: store), isActive: $userModel.isStoreViewActive) {
                            UserMainView()
                                .environmentObject(userModel)
                                .environmentObject(storePost)
                                .environmentObject(cart)
                        
                        }
                    } else {
                        SignInView()
                            .environmentObject(userModel)
                            .environmentObject(storePost)
                            .environmentObject(cart)
                    }
                }
                .onOpenURL { url in
                    guard let host = url.host else { return }
                    deepLinkStoreId = host
                    isLoading = true
                    Task {
                        fetchedStore = try? await Config().fetchStoreById(deepLinkStoreId!)
                        isLoading = false
                        if fetchedStore != nil {
                            userModel.isStoreViewActive=true// Add this line
                        }
                        
                    }
                    
                }
            }
        }
    }
}
