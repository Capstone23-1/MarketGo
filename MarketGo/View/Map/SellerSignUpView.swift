//
//  SellerSignUp.swift
//  MarketGo
//
//  Created by ram on 2023/05/10.
//

import SwiftUI
import FirebaseAuth

struct SellerSignUpView: View {
    @StateObject private var viewModel = SellerSignUpViewModel()
    @State private var moveToSignInView = false
    @State private var moveToCoiceView = false
    @State private var moveToWriteView = false
    @State private var selectedMarket: MarketOne? // 선택된 마켓 정보를 저장할 상태 변수
    @State private var marketName: String = "" // TextField에 바인딩할 변수
    @State private var newStore: StoreElement?
    
    var body: some View {
        NavigationView {
            Form {
               
                TextField("가게명", text: $viewModel.nickName)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                
                HStack{
                    TextField("소속시장", text: $marketName)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Button(action: {
                        self.moveToCoiceView = true
                    }) {
                        Text("찾기")
                            .frame(maxWidth: 50)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .sheet(isPresented: $moveToCoiceView) {
                        SellerMarketChoiceView(selectedMarket: $selectedMarket, isPresented: $moveToCoiceView, marketName: $marketName)
                    }
                }
                
                
                
                
                
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
                    self.moveToWriteView = true
                }) {
                    Text("가게정보입력")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.accentColor)
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity)
                }
                .sheet(isPresented: $moveToWriteView) {
                    StoreEnrollView()
                }
                
                Button(action: {
                    viewModel.signUp { success in
                        if success {
                            print("회원가입 성공, uid: \(viewModel.uid ?? "N/A")")
                            self.moveToSignInView = true
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
                .fullScreenCover(isPresented: $moveToSignInView) {
                    SignInView()
                }
            }.navigationTitle("  상점회원 가입")
        }
        
    }
}

