
import SwiftUI
import FirebaseCore

@main
struct MarketGoApp: App {
    @StateObject var userModel = UserModel()
    @StateObject private var storePost = StorePostViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
    @State var storeId: String? = nil
    @State var store:   StoreElement? = nil
    
    var body: some Scene {
        WindowGroup {
            if let store = store {
                StoreView(store: store)
            
            } else {
                SignInView()
                    .environmentObject(userModel)
                    .environmentObject(storePost)
            }
        }.onChange(of: scenePhase) { phase in
            if phase == .active {
                NotificationCenter.default.addObserver(forName: .openStore, object: nil, queue: .main) { notification in
                    if let storeId = notification.userInfo?["storeId"] as? String {
                        self.storeId = storeId
                        fetchStore()
                    }
                }
            }
        }
    }
    
    func fetchStore() {
        if let storeId = storeId {
            Task {
                do {
                    self.store = try await Config().fetchStoreById(storeId)
                } catch {
                    // handle error
                }
            }
        }
    }
}
extension NSNotification.Name {
    static let openStore = NSNotification.Name("openStore")
}
