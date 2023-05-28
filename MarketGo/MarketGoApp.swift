import SwiftUI
import FirebaseCore

@main
struct MarketGoApp: App {
    @StateObject var userModel = UserModel()
    @StateObject private var storePost = StorePostViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
    
    @State private var deepLinkStoreId: String?
    @State private var fetchedStore: StoreElement?
    @State private var isLoading = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isLoading {
                    ProgressView("Loading...")
                } else if let storeId = deepLinkStoreId, let store = fetchedStore {
                    StoreView(store: store)
                } else {
                    SignInView(cart: cart())
                        .environmentObject(userModel)
                        .environmentObject(storePost)
                        
                }
            }
            .onOpenURL { url in
                guard let host = url.host else { return }
                deepLinkStoreId = host
                isLoading = true
                Task {
                    fetchedStore = try? await Config().fetchStoreById(deepLinkStoreId!)
                    isLoading = false
                }
            }
        }
    }
}
