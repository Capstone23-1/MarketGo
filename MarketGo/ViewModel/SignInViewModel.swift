//
//  SignInViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/05/10.
//

import SwiftUI
import FirebaseAuth
import Firebase

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var error: String? = nil
    @Published var isLoading = false
    
    func signIn(completion: @escaping (Bool) -> Void) {
        isLoading = true
        error = nil
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.error = error.localizedDescription
                self.isLoading = false
                completion(false)
                return
            }
            
            self.isLoading = false
            completion(true)
        }
    }
}
