//
//  SignUpViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/05/09.
//
import SwiftUI
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var error: String? = nil
    @Published var isLoading = false
    
    func signUp(completion: @escaping (Bool) -> Void) {
        isLoading = true
        error = nil
        
        guard password == confirmPassword else {
            error = "비밀번호가 일치하지 않습니다."
            isLoading = false
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
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
