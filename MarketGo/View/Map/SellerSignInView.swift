//
//  SellerSignInView.swift
//  MarketGo
//
//  Created by ram on 2023/05/10.
//

import SwiftUI

// TODO: 로그인 성공시 현위치를 받음
struct SellerSignInView: View {
    
    @Binding var moveToProfileView: Bool
    @ObservedObject private var viewModel = SellerSignInViewModel()
    @Binding var showSignUpView: Bool
    @State var moveToNextView = false
    @EnvironmentObject var userViewModel: UserModel
    
    
    var body: some View {
        
        VStack {
            
            VStack(spacing: 20) {
                // 이메일 입력 필드
                TextField("이메일", text: $viewModel.email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                // 비밀번호 입력 필드
                SecureField("비밀번호", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                
                // 에러 메시지를 표시하는 텍스트 뷰
                if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                // 로그인 버튼
                Button(action: {
                    // 버튼 클릭 시 로그인 시도
                    viewModel.SignIn(userViewModel: userViewModel) { success in
                        if success {
                            // 로그인 성공 시 moveToNextView 상태를 true로 변경하여 MarketSearchView로 전환
                            self.moveToNextView = true
                        } else {
                            print("로그인 실패")
                        }
                    }
                }) {
                    Text("로그인")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(viewModel.isLoading) // 로딩 중일 때는 버튼 비활성화
                .fullScreenCover(isPresented: $moveToNextView) {
                    SellerTempView()
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
            
            
            
            
        }
    }
}

//import SwiftUI
//
//struct SellerSignIn: View {
//
//    @Binding var moveToProfileView: Bool
//    @ObservedObject private var viewModel = UserSignInViewModel()
////    @Binding var showSignUpView: Bool
//    @State var moveToNextView = false
//
//
//
//    var body: some View {
//
//
//        VStack {
//
//            VStack(spacing: 20) {
//
//
//                // 이메일 입력 필드
//                TextField("이메일", text: $viewModel.email)
//                    .autocapitalization(.none)
//                    .keyboardType(.emailAddress)
//                    .disableAutocorrection(true)
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//
//                // 비밀번호 입력 필드
//                SecureField("비밀번호", text: $viewModel.password)
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//
//
//                // 에러 메시지를 표시하는 텍스트 뷰
//                if let error = viewModel.error {
//                    Text(error)
//                        .foregroundColor(.red)
//                }
//
//                // 로그인 버튼
//                Button(action: {
//                    // 버튼 클릭 시 로그인 시도
//                    viewModel.SignIn { success in
//                        if success {
//                            // 로그인 성공 시 moveToNextView 상태를 true로 변경하여 MarketSearchView로 전환
//                            self.moveToNextView = true
//                        } else {
//                            print("로그인 실패")
//                        }
//                    }
//                }) {
//                    Text("로그인")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.accentColor)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                .disabled(viewModel.isLoading) // 로딩 중일 때는 버튼 비활성화
//                .fullScreenCover(isPresented: $moveToNextView) {
////                    MarketSearchView()
//                }
//
//
//
//                NavigationLink(destination:SellerSignUpView()){
//                    Text("회원가입")
//                }
//
//
//            }
//            .padding()
//
//
//
//
//        }
//    }
//}
//
