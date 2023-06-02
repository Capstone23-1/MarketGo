//
//  MapLinkView.swift
//  MarketGo
//
//  Created by ram on 2023/05/07.
//

import SwiftUI

struct Place {
    let latitude: Double
    let longitude: Double
}

struct MapLinkView: View {
    let place: Place
    
    var body: some View {
        VStack {
            Link("네이버 지도로 보기", destination: naverMapURL())
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            
            Link("카카오맵으로 보기", destination: kakaoMapURL())
                .padding()
                .background(Color.yellow)
                .foregroundColor(.black)
                .cornerRadius(8)
        }
    }
    
    func naverMapURL() -> URL {
//        let placeName = makeStringKoreanEncoded()
        let urlString = "https://map.naver.com/v5/search?query=hi"
        return URL(string: urlString)!
    }
    
    func kakaoMapURL() -> URL {
        let urlString = "https://map.kakao.com/link/map/\(place.latitude),\(place.longitude)"
        return URL(string: urlString)!
    }
}


