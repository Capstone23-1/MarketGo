//
//  NetworkService.swift
//  MarketGo
//
//  Created by ram on 2023/05/06.
//
import Foundation
import SwiftUI
import Alamofire
func makeStringKoreanEncoded(_ string: String) -> String {
    return string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? string
}
