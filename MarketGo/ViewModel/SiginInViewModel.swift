//
//  SignInViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/05/10.
//

import SwiftUI
import FirebaseAuth
import Firebase

// SignInViewModel 클래스는 ObservableObject 프로토콜을 채택하여 로그인 관련 상태를 관리합니다.
class SignInViewModel: ObservableObject {
    // 사용자 이메일 입력을 위한 변수
    @Published var email = ""
    // 사용자 비밀번호 입력을 위한 변수
    @Published var password = ""
    
    // 로그인 과정에서 발생할 수 있는 에러 메시지를 저장하는 변수
    @Published var error: String? = nil
    // 로그인 과정 중임을 나타내는 변수 (예: 로딩 인디케이터 표시용)
    @Published var isLoading = false
    @Published var selectedRoll = 0
    
    // TODO: 소비자/상인 나눠서 로그인,받아오는게 다름 cartID,storeID를 각각 받아오고..멤버토큰을 가져옴
    // 로그인 메서드
    // completion: 로그인 성공 여부에 따라 호출되는 콜백 함수
    func SignIn(completion: @escaping (Bool) -> Void) {
        // 로그인 시작 시 isLoading 상태를 true로 변경
        isLoading = true
        // 에러 상태 초기화
        error = nil
        
        // FirebaseAuth를 사용하여 이메일과 비밀번호로 로그인을 시도
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            // 에러 발생 시
            if let error = error {
                // 에러 메시지를 저장하고 isLoading 상태를 false로 변경
                self.error = error.localizedDescription
                self.isLoading = false
                // 콜백 함수 호출 (성공: false)
                completion(false)
                return
            }
            
            // 로그인 성공 시 isLoading 상태를 false로 변경
            self.isLoading = false
            // 콜백 함수 호출 (성공: true)
            completion(true)
        }
    }
}
