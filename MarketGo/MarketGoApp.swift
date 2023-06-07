import SwiftUI
import FirebaseCore

@main
struct MarketGoApp: App {
    @StateObject var userModel = UserModel()
    @StateObject private var storePost = StorePostViewModel()
    @Environment(\.presentationMode) var presentationMode
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
                        StoreView(store: store)
                            .environmentObject(userModel)
                            .environmentObject(storePost)
                            .environmentObject(cart)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarItems(leading: Button(action: {
                                presentationMode.wrappedValue.dismiss()
                                if let window = UIApplication.shared.windows.first {
                                    window.rootViewController = UIHostingController(rootView: UserMainView().environmentObject(userModel).environmentObject(storePost).environmentObject(cart))
                                    window.makeKeyAndVisible()
                                }
                            }) {
                                Image(systemName: "chevron.left")
                                Text("뒤로")
                            })



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
                       
                        
                    }
                    
                }
            }
        }
    }
}
