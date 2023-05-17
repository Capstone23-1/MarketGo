//
//  MainView.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import SwiftUI
struct MainView: View {
    @State private var selectedTab = 0
    @State public var topTitle = "시장"
    
    let member = Member(memberToken: "1234567890", memberName: "John Doe", interestMarket: 1, cartId: 123, storeId: 456, recentLatitude: 37.567, recentLongitude: 126.978)
    

    var body: some View {
        NavigationView {
            VStack {
                TobView()
                TabView(selection: $selectedTab) {
                           ShopView()
                          .tabItem {
                              Image(systemName: "basket")
                              Text("장보기")
                          }
                          .tag(0)
                                Text("Second View")
                                .tabItem {
                                    Image(systemName: "fork.knife")
                                    Text("맛집찾기")
                                }
                                .tag(1)
                            
                                HomeView()
                                .tabItem {
                                    Image(systemName: "house")
                                    Text("Home")
                                }
                                .tag(2)
                            
                            ReviewView(isPresented: Binding.constant(false), storeName: "영찬과일")
                                .tabItem {
                                    Image(systemName: "ellipsis.message")
                                    Text("시장리뷰")
                                }
                                .tag(3)
                            
                                MyPageView(member: member)
                                .tabItem {
                                    Image(systemName: "person")
                                    Text("My")
                                }
                                .tag(4)
                        }
                
            }
        }
        .navigationBarHidden(true)
        


    }
        
}
