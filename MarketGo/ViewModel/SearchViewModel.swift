//
//  SearchViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//
// 이곳은 메소드를 한번에 모아놓는 곳
// 나중에 기능별로 분류하여 사용
import Foundation
import SwiftUI

//화면 터치시 키보드 숨김
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication
            .shared
            .sendAction(#selector(UIResponder
                .resignFirstResponder),
                        to: nil,
                        from: nil,
                        for: nil)
    }
}
#endif
