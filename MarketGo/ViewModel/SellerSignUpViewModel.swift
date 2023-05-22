//
//  SellerSignUpViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/05/16.
//

import SwiftUI
import FirebaseAuth
import Alamofire

// MARK: 판매자 회원가입 창
class SellerSignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword = ""
    @Published var error: String? = nil
    @Published var isLoading: Bool = false
    @Published var uid: String? = nil // 추가된 프로퍼티
    @Published var nickName = ""
    @Published var storeId=0
    @Published var storeMarketId = 0

    
    func signUp(completion: @escaping (Bool, Error?) -> Void) {
        isLoading = true
        guard password == confirmPassword else {
            error = "비밀번호가 일치하지 않습니다."
            isLoading = false
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async { [self] in
                strongSelf.isLoading = false
                print("여기는 signUp")
                print(self?.storeMarketId)
                if let error = error {
                    strongSelf.error = error.localizedDescription
                    completion(false, error)
                } else {
                    print("마지막 storeMarketId:\(String(describing: self?.storeMarketId))")
                    // 회원가입 성공 시 uid 저장
                    strongSelf.uid = Auth.auth().currentUser?.uid
                    let newMemberInfo = MemberPostInfo(memberID: 0, memberToken: strongSelf.uid!, memberName: self!.nickName, interestMarket: self!.storeMarketId, cartID: nil, storeID: self?.storeId, recentLatitude: nil, recentLongitude: nil)
                    Config().postSellerMemberInfo(memberPostInfo: newMemberInfo) { result in
                        switch result {
                            case .success(let data):
                                // 요청 성공
                                // 데이터를 처리하는 코드 작성
                                print(data)
                                completion(true, nil)
                            case .failure(let error):
                                // 요청 실패
                                // 에러를 처리하는 코드 작성
                                print(error)
                                completion(false, error)
                        }
                    }
                }
            }
        }
    }

}

class StoreVM: ObservableObject{
    @Published var storeInfo = ""
}
