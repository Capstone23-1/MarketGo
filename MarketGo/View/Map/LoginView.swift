//
//  LoginView.swift
//  MarketGo
//
//  Created by ram on 2023/05/10.
//
import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var showSignUpView = false
    @State private var moveToMarketSearchView = false
    
    var body: some View {
        VStack {
            TextField("이메일", text: $viewModel.email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            SecureField("비밀번호", text: $viewModel.password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                viewModel.login { success in
                    if success {
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
            .disabled(viewModel.isLoading)
            .fullScreenCover(isPresented: $moveToMarketSearchView) {
                MarketSearchView()
            }
            
            Button(action: {
                showSignUpView.toggle()
            }) {
                Text("회원가입")
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $showSignUpView) {
                SignUpView()
            }
            
            Spacer()
        }
        .padding()
    }
}
