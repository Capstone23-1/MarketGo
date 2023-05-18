import Alamofire
import SwiftUI



struct StorePostTestView: View {
    @StateObject var viewModel = StorePostViewModel()
    
    var body: some View {
        VStack {
            Button("Enroll Store") {
                viewModel.enrollStore()
            }

            if let storeID = viewModel.newStore?.storeID {
                Text("Store ID: \(storeID)")
            } else {
                Text("Store ID not yet fetched")
            }
        }
    }
}
