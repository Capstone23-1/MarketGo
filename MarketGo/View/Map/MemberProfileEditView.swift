import SwiftUI
import Alamofire

struct MemberProfileEditView: View {
    @EnvironmentObject var userModel: UserModel
    @StateObject private var vm = MemberProfileEditViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isLoading = false
    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                    
                    Form {
                        Section(header: Text("Member ID")) {
                            TextField("Member ID", value: $vm.memberID, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        Section(header: Text("Member Token")) {
                            TextField("Member Token", text: $vm.memberToken)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        Section(header: Text("Member Name")) {
                            TextField("Member Name", text: $vm.memberName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        Section(header: Text("Interest Market")) {
                            TextField("Interest Market", value: $vm.interestMarket, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        Section(header: Text("Cart ID")) {
                            TextField("Cart ID", value: $vm.cartId, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        Section(header: Text("Store ID")) {
                            TextField("Store ID", value: $vm.storeId, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        Section(header: Text("Recent Latitude")) {
                            TextField("Recent Latitude", value: $vm.recentLatitude, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        Section(header: Text("Recent Longitude")) {
                            TextField("Recent Longitude", value: $vm.recentLongitude, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    // Save button
                    Button(action: {
                        isLoading = true
                        Task{
                            vm.updateMemberInfo()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                userModel.currentUser = vm.successMemberInfo
                                isLoading = false
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }) {
                        Text("저장")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(isLoading)
                    
                    Spacer()
                }
                if isLoading {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .frame(width: 100, height: 100)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .shadow(radius: 10)
                }
                
            }
            .padding()
            .onAppear {
                if let memberInfo = userModel.currentUser {
                    vm.memberID = memberInfo.memberID
                    vm.memberToken = memberInfo.memberToken ?? ""
                    vm.memberName = memberInfo.memberName ?? ""
                    vm.interestMarket = memberInfo.interestMarket?.marketID ?? 0
                    vm.cartId = memberInfo.cartID?.cartID ?? 0
                    vm.storeId = memberInfo.storeID?.storeID ?? 0
                    vm.recentLatitude = memberInfo.recentLatitude ?? 0.0
                    vm.recentLongitude = memberInfo.recentLongitude ?? 0.0
                }
            }
        }
    }
}


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
    
    
    
    @Published var successMemberInfo:MemberInfo?
    
    func updateMemberInfo() {
        
        
        
        let enMemberToken = makeStringKoreanEncoded(memberToken)
        let enMemberName = makeStringKoreanEncoded(memberName)
        
        let url = "http://3.34.33.15:8080/member/\(String(describing: memberID))?memberToken=\(enMemberToken)&memberName=\(enMemberName)&interestMarket=\(String(describing: interestMarket))&cartId=\(cartId)&storeId=\(storeId)&recentLatitude=\(recentLatitude)&recentLongitude=\(recentLongitude)"
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        AF.request(url, method: .put, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MemberInfo.self) { [self] response in
                
                
                switch response.result {
                    case .success(let up):
                        print("put 메서드 성공",up)
                        successMemberInfo = up
                        
                    case .failure(let error):
                        print("Error updating member info:", error)
                }
            }
    }
}

