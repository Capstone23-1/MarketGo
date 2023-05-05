//
//  MypageView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import SwiftUI


struct MyPageView: View {
    @State var member: Member
    @State private var nameEditMode = false
    @State private var newName = ""

    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 20)
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width:100, height:100)
            
            Spacer().frame(height: 20)
            
            HStack {
                Text("이름")
                Spacer()
                if nameEditMode {
                    TextField("이름", text: $newName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 150)
                    Button(action: {
                        member.memberName = newName
                        nameEditMode = false
                    }) {
                        Text("완료")
                    }
                } else {
                    Text(member.memberName)
                    Button(action: {
                        nameEditMode = true
                        newName = member.memberName
                    }) {
                        Text("수정")
                    }
                }
            }
            HStack {
                Text("관심 시장")
                Spacer()
                Text("\(member.interestMarket)")
            }
            HStack {
                Text("장바구니")
                Spacer()
                Text("\(member.cartId)")
            }
            HStack {
                Text("Token")
                Spacer()
                Text(member.memberToken)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("My Page", displayMode: .inline)
    }
}



struct MyPageView_Previews: PreviewProvider {
    static let member = Member(memberToken: "1234567890", memberName: "John Doe", interestMarket: 1, cartId: 123, storeId: 456, recentLatitude: 37.567, recentLongitude: 126.978)
    
    static var previews: some View {
        NavigationView {
            MyPageView(member: member)
        }
    }
}
