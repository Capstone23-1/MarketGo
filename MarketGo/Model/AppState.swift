//
//  AppState.swift
//  MarketGo
//
//  Created by ram on 2023/05/24.
//

import Foundation
class AppState: ObservableObject {
    @Published var storeId: String? = nil
    @Published var store: StoreElement? = nil
    
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
