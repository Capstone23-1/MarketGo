//
//  MypageView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import SwiftUI


struct UserMyPageView: View {
    @EnvironmentObject var userModel: UserModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isLogoutActive = false
    @State var isLinkActive = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 200)
            
            CardView(title: "이름", value: userModel.currentUser?.memberName ?? "", iconName: "person")
            CardView(title: "최근 방문 시장", value: userModel.currentUser?.interestMarket?.marketName ?? "", iconName: "house")
           
            // 로그아웃 버튼
            Button(action: {
                // 여기서 userModel 초기화와 navigation stack 제거를 처리합니다.
                userModel.currentUser = nil // userModel 초기화
                isLogoutActive = true
                // 모든 네비게이션 스택을 제거하고 root view로 돌아갑니다.
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("로그아웃")
                    .foregroundColor(.blue)
            }.fullScreenCover(isPresented: $isLogoutActive) {
                SignInView()
            }
            
            // 다른 기능을 위한 버튼 예시
            Button(action: {
                self.isLinkActive = true
            }) {
                Text("닉네임 변경")
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $isLinkActive) {
                MemberProfileEditView()
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("My Page", displayMode: .inline)
    }
}

class UserModel: ObservableObject {
    @Published var currentUser: MemberInfo? 
    @Published var NMap: Document?
    @Published var isPresentedUserMainView = false // Add this line
    @Published var cState: [Int: Int] = [:]
    @Published var ten = 0
    @Published var marketName = ""
}
