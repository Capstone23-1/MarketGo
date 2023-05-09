//
//  SignInView.swift
//  MarketGo
//
//  Created by ram on 2023/05/10.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = SignInViewModel()
    @State private var loginSucceeded = false
    
    var body: some View {
        VStack {
            if loginSucceeded {
                MarketSearchView()
            } else {
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
                    viewModel.signIn { success in
                        if success {
                            print("로그인 성공!")
                            loginSucceeded = true
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
                
                Spacer()
            }
        }
        .padding()
    }
}
