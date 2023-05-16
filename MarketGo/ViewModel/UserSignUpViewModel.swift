//
//  SignUpViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/05/09.
//

import SwiftUI
import FirebaseAuth
import Alamofire
// MARK: 소비자 회원가입 창
class UserSignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword = ""
    @Published var error: String? = nil
    @Published var isLoading: Bool = false
    @Published var uid: String? = nil // 추가된 프로퍼티
    @Published var nickName = ""
    
    
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
                    let newMemberInfo = MemberInfo(memberId: nil, memberToken: strongSelf.uid, memberName: self?.nickName, interestMarket: nil, cartID: nil, storeID: nil, recentLatitude: 0, recentLongitude: 0)
                    postUserMemberInfo(memberInfo: newMemberInfo) { result in
                        switch result {
                            case .success(let data):
                                // 요청 성공
                                // 데이터를 처리하는 코드 작성
                                print(data)
                            case .failure(let error):
                                // 요청 실패
                                // 에러를 처리하는 코드 작성
                                print(error)
                        }
                    }
                    
                    
                    completion(true)
                }
            }
        }
    }
}

