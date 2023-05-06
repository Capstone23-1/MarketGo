//
//  SignUpView.swift
//  MarketGo
//
//  Created by ram on 2023/05/07.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var fullName = ""
    @State private var agreeAll = false
    @State private var agreeTerms = false
    @State private var agreePrivacy = false
    @State private var agreeAds = false

    var body: some View {
        NavigationView {
            VStack {
          
                TextField("이메일", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    .padding(.vertical,10)
                    .autocapitalization(.none)

                SecureField("비밀번호", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.vertical,10)
                    .padding(.horizontal, 16)
                    .autocapitalization(.none)

                SecureField("비밀번호 확인", text: $confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.vertical,10)
                    .padding(.horizontal, 16)
                    .autocapitalization(.none)

                TextField("성명", text: $fullName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    .autocapitalization(.none)

//                VStack(alignment: .leading) {
//                    Toggle(isOn: $agreeAll) {
//                        Text("전체 동의")
//
//                    }
//                    .padding(.leading, 16)
//
//                    Toggle(isOn: $agreeTerms) {
//                        Text("[필수] 시장에가면 이용약관에 동의합니다.")
//                    }
//                    .padding(.leading, 16)
//
//                    Toggle(isOn: $agreePrivacy) {
//                        Text("[필수] 개인정보 수집 및 이용에 동의합니다.")
//                    }
//                    .padding(.leading, 16)
//
//                    Toggle(isOn: $agreeAds) {
//                        Text("[선택] 광고성 정보 수신(SMS/이메일)에 동의합니다.")
//                    }
//                    .padding(.leading, 16)
//                }
//                .padding(.top, 16)

                Button(action: {
                    signUp()
                }) {
                    Text("회원가입")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                }
                .padding(.vertical,10)
                Spacer()
            }
            .navigationBarTitle("회원가입", displayMode: .inline)
        }
    }
    
    private func signUp() {
        // 회원가입 로직을 여기에 구현하세요.
        print("Email: \(email)")
        print("Password: \(password)")
        print("Confirm Password: \(confirmPassword)")
        print("Full Name: \(fullName)")
    }
    
}
