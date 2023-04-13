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
                            
                            Text("Third View")
                                .tabItem {
                                    Image(systemName: "house")
                                    Text("Home")
                                }
                                .tag(2)
                            
                            Text("Fourth View")
                                .tabItem {
                                    Image(systemName: "bubble.left")
                                    Text("채팅")
                                }
                                .tag(3)
                            
                            Text("Fifth View")
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
