import SwiftUI

struct SellerSignInView: View {
    
    @Binding var moveToProfileView: Bool
    @StateObject private var viewModel2 = SellerSignInViewModel()
    @Binding var showSignUpView: Bool
    @State var moveToMarketSearchView = false
    @State var currentUser: MemberInfo? = nil
    @EnvironmentObject var userViewModel: UserModel
    @StateObject var marketModel = MarketModel()
//    @State var isLoading: Bool = false
    var body: some View {
        
        
        ZStack {
            
            VStack(spacing: 20) {
                
                
                // 이메일 입력 필드
                TextField("이메일", text: $viewModel2.email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                // 비밀번호 입력 필드
                SecureField("비밀번호", text: $viewModel2.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                
                // 에러 메시지를 표시하는 텍스트 뷰
                if let error = viewModel2.error {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                // 로그인 버튼
                Button(action: {
                    // 버튼 클릭 시 로그인 시도
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        
                        
                            viewModel2.SignIn(userViewModel: userViewModel) { success in
                                if success {
                                    
                                    self.moveToMarketSearchView = true
                                    
                                } else {
                                    print("로그인 실패")
                                }
                            }
//                        }
                         
                        
                    
                    
                }) {
                    Text("로그인")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(viewModel2.isLoading) // 로딩 중일 때는 버튼 비활성화
                .fullScreenCover(isPresented: $moveToMarketSearchView){
                    SellerHomeView()
                }

                
                
                // 회원가입 버튼
                Button(action: {
                    // 버튼 클릭 시 회원가입 창 표시
                    showSignUpView.toggle()
                }) {
                    Text("회원가입")
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $showSignUpView) {
                    SellerSignUpView()
                }
                
                
            }
            .padding()
//            if isLoading {
//                ProgressView()
//                    .scaleEffect(2)
//                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
//                    .frame(width: 100, height: 100)
//                    .background(Color.white.opacity(0.8))
//                    .cornerRadius(20)
//                    .shadow(radius: 10)
//            }
//
            
            
        }
    }
}
