import SwiftUI
import FirebaseAuth
import Alamofire

class UserSignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword = ""
    @Published var error: String? = nil
    @Published var isLoading: Bool = false
    @Published var uid: String? = nil // 추가된 프로퍼티
    @Published var nickName = ""
    @Published var cartId=0
    @Published var memberId=""
    
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
                    let newMemberInfo = MemberPostInfo(memberID: 0, memberToken: strongSelf.uid!, memberName: self!.nickName, interestMarket: 0, cartID: self!.cartId, storeID: nil, recentLatitude: 0.0, recentLongitude: 0.0)
                    Config().postUserMemberInfo(memberPostInfo: newMemberInfo) { result in
                        switch result {
                            case .success(let data):
                                // 요청 성공
                                // 데이터를 처리하는 코드 작성
                                do {
                                    let decoder = JSONDecoder()
                                    let memberInfo = try decoder.decode(MemberInfo.self, from: data)
                                    //                                self?.memberId=String(describing:memberInfo.memberID)
                                    //                                StoreDogamViewModel().memberID=String(describing:memberInfo.memberID)
                                    StoreDogamViewModel().postMemeberIndex(memberID: String(describing:memberInfo.memberID))
                                    print(memberInfo)
                                    
                                    // memberInfo를 활용하여 추가적인 작업 수행
                                } catch {
                                    print("Error decoding MemberInfo:", error)
                                }
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


// POST 요청을 수행하는 함수
func postCartData(completion: @escaping (Result<Cart, Error>) -> Void) {
    let url = "http://3.34.33.15:8080/cart"
    var cartRequest = CartRequest(goodsId1: 0, unit1: 0, goodsId2: 0, unit2: 0, goodsId3: 0, unit3: 0, goodsId4: 0, unit4: 0, goodsId5: 0, unit5: 0, goodsId6: 0, unit6: 0, goodsId7: 0, unit7: 0, goodsId8: 0, unit8: 0, goodsId9: 0, unit9: 0, goodsId10: 0, unit10: 0)
    AF.request(url, method: .post, parameters: cartRequest)
        .validate()
        .responseDecodable(of: Cart.self) { (response) in
            switch response.result {
                case .success(let storeElement):
                    print(storeElement)
                    
                    DispatchQueue.main.async {
                        
                    }
                    completion(.success(storeElement))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
            }
        }
}

// 데이터 모델 정의
struct CartRequest: Codable {
    let goodsId1: Int
    let unit1: Int
    let goodsId2: Int
    let unit2: Int
    let goodsId3: Int
    let unit3: Int
    let goodsId4: Int
    let unit4: Int
    let goodsId5: Int
    let unit5: Int
    let goodsId6: Int
    let unit6: Int
    let goodsId7: Int
    let unit7: Int
    let goodsId8: Int
    let unit8: Int
    let goodsId9: Int
    let unit9: Int
    let goodsId10: Int
    let unit10: Int
}
