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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }
}
