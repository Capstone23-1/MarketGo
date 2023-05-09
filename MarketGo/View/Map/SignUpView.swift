//
//  SignUpView.swift
//  MarketGo
//
//  Created by ram on 2023/05/07.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    
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
            
            SecureField("비밀번호 확인", text: $viewModel.confirmPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                viewModel.signUp { success in
                    if success {
                        print("회원가입 성공!")
                    } else {
                        print("회원가입 실패")
                    }
                }
            }) {
                Text("회원가입")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(viewModel.isLoading)
            
            Spacer()
        }
        .padding()
    }
}
