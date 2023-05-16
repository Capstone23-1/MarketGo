//
//  MarketGoApp.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import SwiftUI
import FirebaseCore


@main
struct MarketGoApp: App {
    @StateObject var userViewModel = UserViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    //파이어베이스 연결부분
    var body: some Scene {
        WindowGroup {
            SignInView()
                .environmentObject(userViewModel)
        }
    }
}
