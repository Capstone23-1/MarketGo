//
//  MainView.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import SwiftUI
struct UserMainView: View {
    @State private var selectedTab = 0
    @State public var topTitle = "시장"
    @EnvironmentObject var userModel : UserModel

    var body: some View {
        VStack {
            
            TabView(selection: $selectedTab) {
                       ShopView()
                      .tabItem {
                          Image(systemName: "basket")
                          Text("장보기")
                      }
                      .tag(0)
                            EatingHouseView()
                            .tabItem {
                                Image(systemName: "fork.knife")
                                Text("맛집찾기")
                            }
                            .tag(1)
                        
                            UserHomeView()
                            .tabItem {
                                Image(systemName: "house")
                                Text("Home")
                            }
                            .tag(2)
                        
                            MarketReviewView()
                            .tabItem {
                                Image(systemName: "ellipsis.message")
                                Text("시장리뷰")
                            }
                            .tag(3)
                        
                            UserMyPageView()
                            .tabItem {
                                Image(systemName: "person")
                                Text("My")
                            }
                            .tag(4)
                    }
            
        }
        . navigationBarItems(trailing:NavigationLink(destination: CartView()) {
            Image(systemName: "cart")
                .resizable()
        }
          
        )
        
        


    }
        
}
