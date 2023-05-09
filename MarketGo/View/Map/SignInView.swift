//
//  SignInView.swift
//  MarketGo
//
//  Created by ram on 2023/05/10.
//
import SwiftUI

struct SignInView: View {
    // SignInViewModel을 StateObject로 선언하여 로그인 상태를 관리합니다.
    @StateObject private var viewModel = SignInViewModel()
    // 회원가입 창을 표시할지 여부를 결정하는 State 변수
    @State private var showSignUpView = false
    // 로그인 성공 시 MarketSearchView로 전환할지 여부를 결정하는 State 변수
    @State private var moveToMarketSearchView = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                VStack(spacing: 20) { // 텍스트 필드 간 간격을 20으로 설정합니다.
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
                        viewModel.SignIn { success in
                            if success {
                                // 로그인 성공 시 moveToMarketSearchView 상태를 true로 변경하여 MarketSearchView로 전환
                                self.moveToMarketSearchView = true
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
                    .fullScreenCover(isPresented: $moveToMarketSearchView) {
                        MarketSearchView()
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
                        SignUpView()
                    }
                }
                .padding()
                
                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
