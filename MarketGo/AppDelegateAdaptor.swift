
import SwiftUI
import Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    var storeIdToOpen: Int? // Add this line
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let urlString = url.absoluteString
        let components = urlString.split(separator: "/")

        if let lastComponent = components.last, let storeId = Int(lastComponent) {
            storeIdToOpen = storeId
        }

        return true
      }
    
}
