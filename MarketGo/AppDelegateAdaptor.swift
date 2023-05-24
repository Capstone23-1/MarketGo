import SwiftUI
import Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Parse the URL
        let urlPath = url.path
        let pathComponents = urlPath.components(separatedBy: "/")
        if pathComponents.count > 1 {
            let storeIdString = pathComponents[1]
            if let storeId = Int(storeIdString) {
                // Store the storeId in some global state
                // Then navigate to the StoreView with this storeId
            }
        }
        return true
    }
    
}
