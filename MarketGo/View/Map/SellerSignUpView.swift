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
    @State private var selectedMarket: MarketOne? // 선택된 마켓 정보를 저장할 상태 변수
    @State private var marketName: String = "" // TextField에 바인딩할 변수
    @State var category = ""
    @State var id = ""
    @State private var selectedCategoryId = 0
    let categories = [
        (id: 0, name: "분류"),
        (id: 1, name: "농산물"),
        (id: 2, name: "수산물"),
        (id: 3, name: "축산물"),
        (id: 4, name: "반찬"),
        (id: 5, name: "가공식품"),
        (id: 6, name: "건강식품"),
        (id: 7, name: "생활용품"),
        (id: 8, name: "기타"),
    ]
    var body: some View {
        VStack {
            Text("상인회원 회원가입")
                .font(.headline)
            ImageUploadView(category: $category, id: $id)
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
            
            Picker(selection: $selectedCategoryId, label: Text("카테고리")) {
                ForEach(categories, id: \.id) { category in
                    Text(category.name).tag(category.id)
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
        }
        .padding()
    }
}

