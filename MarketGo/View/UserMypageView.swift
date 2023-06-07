//
//  MypageView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import SwiftUI


struct UserMyPageView: View {
    @EnvironmentObject var userModel: UserModel
    @State var isLinkActive = false
    @State var isLogoutActive = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 200)
            
            CardView(title: "이름", value: userModel.currentUser?.memberName ?? "", iconName: "person")
            CardView(title: "최근 방문 시장", value: userModel.currentUser?.interestMarket?.marketName ?? "", iconName: "house")
           
//            HStack {
//                Text("장바구니")
//                Spacer()
//                //Text("\(userModel.currentUser?.cartID ?? 0)")
//            }
//            HStack {
//                Text("member id")
//                Spacer()
//                Text("\(userModel.currentUser?.memberID ?? 0)")
//                    .font(.footnote)
//                    .foregroundColor(.gray)
//            }
            
//            HStack {
//                Text("cart id")
//                Spacer()
//                Text("\(userModel.currentUser?.cartID?.cartID ?? 0)")
//                    .font(.footnote)
//                    .foregroundColor(.gray)
//            }
            
            Button(action: {
                
                self.isLogoutActive = true
            }) {
                Text("로그아웃")
                    .foregroundColor(.blue)
            }
            .fullScreenCover(isPresented: $isLogoutActive) {
                SignInView()
            }
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
