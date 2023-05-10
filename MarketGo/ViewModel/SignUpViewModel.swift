//
//  SignUpViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/05/09.
//

import SwiftUI
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword = ""
    @Published var error: String? = nil
    @Published var isLoading: Bool = false
    @Published var uid: String? = nil // 추가된 프로퍼티
    
    func signUp(completion: @escaping (Bool) -> Void) {
        isLoading = true
        guard password == confirmPassword else {
                    error = "비밀번호가 일치하지 않습니다."
                    isLoading = false
                    return
                }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.isLoading = false
                
                if let error = error {
                    strongSelf.error = error.localizedDescription
                    completion(false)
                } else {
                    // 회원가입 성공 시 uid 저장
                    strongSelf.uid = Auth.auth().currentUser?.uid
                    completion(true)
                }
            }
        }
    }
}
