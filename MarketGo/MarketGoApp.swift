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
    @StateObject var userModel = UserModel()
    @StateObject private var storePost = StorePostViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    //파이어베이스 연결부분
    var body: some Scene {
        WindowGroup {
            SignInView()
                .environmentObject(userModel)
                .environmentObject(storePost)
                
                
        }
    }
}
