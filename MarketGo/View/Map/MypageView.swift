//
//  MypageView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import SwiftUI

struct MyPageView: View {
    let member: Member

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Name")
                Spacer()
                Text(member.memberName)
            }
            HStack {
                Text("Interest Market")
                Spacer()
                Text("\(member.interestMarket)")
            }
            HStack {
                Text("Recent Location")
                Spacer()
                VStack {
                    Text("Lat: \(member.recentLatitude)")
                    Text("Lng: \(member.recentLongitude)")
                }
            }
            HStack {
                Text("Cart ID")
                Spacer()
                Text("\(member.cartId)")
            }
            HStack {
                Text("Store ID")
                Spacer()
                Text("\(member.storeId)")
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
