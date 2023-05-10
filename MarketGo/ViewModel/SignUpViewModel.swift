//
//  SignUpViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/05/09.
//

import SwiftUI
import FirebaseAuth
import Alamofire

class SignUpViewModel: ObservableObject {
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
                    let newMemberInfo = MemberInfo(memberID: nil, memberToken: strongSelf.uid, memberName: self?.nickName, interestMarket: nil, cartID: nil, storeID: nil, recentLatitude: 0, recentLongitude: 0)
                    postMemberInfo(memberInfo: newMemberInfo) { result in
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
func postMemberInfo(memberInfo: MemberInfo, completion: @escaping (Result<Data, Error>) -> Void) {
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    let encodeName = makeStringKoreanEncoded(memberInfo.memberName!)

    var requestURL = "http://3.34.33.15:8080/member?memberId=&memberToken=\(memberInfo.memberToken ?? "null")&memberName=\(memberInfo.memberName ?? "null")&interestMarket=0&cartId=0&storeId=0&recentLatitude=0&recentLongitude=0"
    print(requestURL)
    AF.request(requestURL, method: .post, parameters: memberInfo, encoder: JSONParameterEncoder.default, headers: headers).responseData { response in
        switch response.result {
        case .success(let data):
            completion(.success(data))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
