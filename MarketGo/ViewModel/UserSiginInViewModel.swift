import SwiftUI
import FirebaseAuth
import Firebase
import Alamofire
// MARK: 소비자 로그인 UI
// SignInViewModel 클래스는 ObservableObject 프로토콜을 채택하여 로그인 관련 상태를 관리합니다.
class UserSignInViewModel: ObservableObject {
    // 사용자 이메일 입력을 위한 변수
    @Published var email = ""
    // 사용자 비밀번호 입력을 위한 변수
    @Published var password = ""
    
    // 로그인 과정에서 발생할 수 있는 에러 메시지를 저장하는 변수
    @Published var error: String? = nil
    // 로그인 과정 중임을 나타내는 변수 (예: 로딩 인디케이터 표시용)
    @Published var isLoading = false
    @Published var uid: String? = nil
    @Published var currentUser: MemberInfo?
    
    // TODO: 소비자/상인 나눠서 로그인,받아오는게 다름 cartID,storeID를 각각 받아오고..멤버토큰을 가져옴
    // 로그인 메서드
    // completion: 로그인 성공 여부에 따라 호출되는 콜백 함수
    func SignIn(userViewModel: UserModel,completion: @escaping (Bool) -> Void) {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.isLoading = false
                
                if let error = error {
                    strongSelf.error = error.localizedDescription
                    completion(false)
                } else {
                    // 로그인 성공 시 uid 저장
                    strongSelf.uid = Auth.auth().currentUser?.uid
                    
                    Config().getMemberInfo(uid: strongSelf.uid!) { result in
                        print(result)
                        switch result {
                            case .success(let memberInfo):
                                // 받아온 데이터를 사용하여 UI 구성 등 필요한 작업을 수행
                                userViewModel.currentUser = memberInfo
                                
                                //                                print(memberInfo)
                            case .failure(let error):
                                print(error)
                        }
                    }
                    completion(true)
                }
            }
        }
        
    }
    
    
    
}

class UserModel: ObservableObject {
    @Published var currentUser: MemberInfo? = nil
    @Published var NMap: Document?
    @Published var isStoreViewActive = false // Add this line
    @Published var isCouponUsed = false
}

