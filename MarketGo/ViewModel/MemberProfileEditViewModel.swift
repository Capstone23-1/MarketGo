import SwiftUI
import Alamofire
import Combine

class MemberProfileEditViewModel: ObservableObject {
    @EnvironmentObject var userModel: UserModel
    @Published var memberPostInfo: MemberPostInfo?
    
    @Published var memberID = 0
    @Published var memberToken = ""
    @Published var memberName = ""
    @Published var interestMarket = 0
    @Published var cartId = 0
    @Published var storeId = 0
    @Published var recentLatitude = 0.0
    @Published var recentLongitude = 0.0
    @Published var successMemberInfo: MemberInfo?
   
    
    
    func updateMemberInfo() async throws {
        let enMemberToken = makeStringKoreanEncoded(memberToken)
        let enMemberName = makeStringKoreanEncoded(memberName)
        
        let url = "http://3.34.33.15:8080/member/\(String(describing: memberID))?memberToken=\(enMemberToken)&memberName=\(enMemberName)&interestMarket=\(String(describing: interestMarket))&cartId=\(String(describing: cartId))&storeId=\(String(describing: storeId))&recentLatitude=0&recentLongitude=0"
        
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .put, headers: headers)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: MemberInfo.self) { [self] response in
                    switch response.result {
                    case .success(let up):
                        successMemberInfo = up
                        continuation.resume(returning: ())
                    case .failure(let error):
                        print("Error updating member info:", error)
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
