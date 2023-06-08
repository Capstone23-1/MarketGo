//
//  SignUpView.swift
//  MarketGo
//
//  Created by ram on 2023/05/07.
//
import SwiftUI
import FirebaseAuth
import Alamofire
struct UserSignUpView: View {
    @StateObject private var viewModel = UserSignUpViewModel()
    @State private var moveToSignInView = false
    @State private var isLoading: Bool = false
    @StateObject private var vm = StoreDogamViewModel()
    var body: some View {
        VStack {
            Text("일반회원 회원가입")
                .font(.headline)
            
            TextField("닉네임", text: $viewModel.nickName)
                .autocapitalization(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            TextField("이메일", text: $viewModel.email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            SecureField("비밀번호", text: $viewModel.password)
                .textContentType(.newPassword)
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                
            SecureField("비밀번호 확인", text: $viewModel.confirmPassword)
                .textContentType(.newPassword) 
                .padding()
                .background(Color(.systemGray6))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .cornerRadius(8)
                
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                Task {
                    await processSignUp()
                }           }) {
                    Text("회원가입")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(viewModel.isLoading)
                .fullScreenCover(isPresented: $moveToSignInView) {
                    SignInView()
                }
        }
        .padding()
    }
    func processSignUp() async {
        isLoading = true
        do {
            
            
            await postCartData { result in
                switch result {
                    case .success(let cart):
                        viewModel.cartId=cart.cartID!
                        print(cart)
                        
                    case .failure(let error):
                        // 에러가 발생했을 때의 동작
                        print("Error enrolling store: \(error)")
                }
            }
            
            DispatchQueue.main.async {
                viewModel.signUp { success in
                    if success {
                        
                        print("회원가입 성공, uid: \(viewModel.uid ?? "N/A")")
                        self.moveToSignInView = true
                    } else {
                        print("회원가입 실패")
                    }
                }
            }
        } catch {
            print("Error uploading image: \(error)")
            isLoading = false
        }
    }
}
