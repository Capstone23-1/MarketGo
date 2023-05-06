//
//  FindPathView.swift
//  MarketGo
//
//  Created by ram on 2023/05/07.
//

import SwiftUI

import SwiftUI

struct FindPathView: View {
    @Binding var selectedMarket: MarketOneElement?
    
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
        if let naverURL = URL(string: "nmap://route/walk?dlat=\(selectedMarket?.marketLatitude)&dlng=\(selectedMarket?.marketLongitude)&appname=\(Config().bundleID)") {
            if UIApplication.shared.canOpenURL(naverURL) {
                UIApplication.shared.open(naverURL)
            } else {
                let webURL = URL(string: "https://m.map.naver.com/directions/?waypoint=\(selectedMarket?.marketLatitude),\(selectedMarket?.marketLongitude)")!
                UIApplication.shared.open(webURL)
            }
        }
    }
    
    func openKakaoMap() {
        if let kakaoURL = URL(string: "kakaomap://route?ep=\(String(describing: selectedMarket?.marketLatitude)),\(String(describing: selectedMarket?.marketLongitude))&by=FOOT") {
            if UIApplication.shared.canOpenURL(kakaoURL) {
                UIApplication.shared.open(kakaoURL)
            } else {
                let webURL = URL(string: "https://map.kakao.com/link/to/\(String(describing: selectedMarket?.marketLatitude)),\(String(describing: selectedMarket?.marketLongitude))")!
                UIApplication.shared.open(webURL)
            }
        }
    }
}

