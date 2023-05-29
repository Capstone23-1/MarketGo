//
//  EditProfileView.swift
//  MarketGo
//
//  Created by ram on 2023/05/10.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var userModel: UserModel
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
         
            VStack(alignment: .leading, spacing: 20) {
                Text("이름")
                TextField("이름 입력", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Text("이메일")
                TextField("이메일 입력", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Text("비밀번호")
                SecureField("비밀번호 입력", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Text("비밀번호 확인")
                SecureField("비밀번호 확인 입력", text: $confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            
            Button(action: {
                // 정보 수정 처리를 여기에 추가합니다.
            }) {
                Text("수정 완료")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
}
