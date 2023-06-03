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
    @State private var isStoreViewActive = false // Add this line
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack {
                    if isLoading {
                        ProgressView("Loading...")
                    } else if let store = fetchedStore {
                        NavigationLink(destination: StoreView(store: store), isActive: $isStoreViewActive) {
                            EmptyView() // Replace 'Text("Go to Store")' with 'EmptyView()'
                        }
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
                        if fetchedStore != nil {
                            isStoreViewActive = true // Add this line
                        }
                    }
                }
            }
        }
    }
}
