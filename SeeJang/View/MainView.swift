//
//  ContentView.swift
//  SeeJang
//
//  Created by ram on 2023/03/25.
//

import SwiftUI
struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("First View")
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("장보기")
                }
                .tag(0)
            
            Text("Second View")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Second")
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
                    Image(systemName: "4.circle")
                    Text("맛집찾기")
                }
                .tag(3)
            
            Text("Fifth View")
                .tabItem {
                    Image(systemName: "5.circle")
                    Text("My")
                }
                .tag(4)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
