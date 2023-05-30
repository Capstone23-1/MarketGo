//
//  FindPathView.swift
//  MarketGo
//
//  Created by ram on 2023/05/07.
//

import SwiftUI

import SwiftUI

struct FindPathView: View {
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        VStack {
            Button(action: openNaverMap) {
                Text("네이버 지도로 길찾기")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            .padding()
            
            Button(action: openKakaoMap) {
                Text("카카오맵으로 길찾기")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
    
    func openNaverMap() {
        if let selectedMarketName = userModel.currentUser?.interestMarket?.marketName{
            let name = makeStringKoreanEncoded(selectedMarketName)
            let encodedBundleID = makeStringKoreanEncoded(Config().bundleID)
            
            if let naverURL = URL(string: "nmap://place?lat=\(userModel.currentUser?.interestMarket?.marketLatitude ?? cauLocation.lat)&lng=\(userModel.currentUser?.interestMarket?.marketLongitude ?? cauLocation.lng)&name=\(name)&appname=\(encodedBundleID)") {
                if UIApplication.shared.canOpenURL(naverURL) {
                    UIApplication.shared.open(naverURL)
                } else {
                    
//                    let webURL = URL(string: "https://map.naver.com/v5/search?query=\(name)")
//                    UIApplication.shared.open(webURL!)
                    let webURL = URL(string: "https://map.naver.com/v5/search?query=\(name)")
                    UIApplication.shared.open(webURL!)
                }
            }
        } else {
            print("Error: Missing name or bundleID")
        }
        
        
    }
    
    func openKakaoMap() {
        
        if let kakaoURL = URL(string: "kakaomap://route?ep=\(String(describing: userModel.currentUser?.interestMarket?.marketLatitude)),\(String(describing: userModel.currentUser?.interestMarket?.marketLongitude))&by=FOOT") {
            if UIApplication.shared.canOpenURL(kakaoURL) {
                UIApplication.shared.open(kakaoURL)
            } else {
                let webURL = URL(string: "https://map.kakao.com/link/to/\(String(describing: userModel.currentUser?.interestMarket?.marketLatitude)),\(String(describing: userModel.currentUser?.interestMarket?.marketLongitude))")!
                UIApplication.shared.open(webURL)
            }
        }
    }
}

