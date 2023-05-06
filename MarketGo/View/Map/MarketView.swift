////
////  MarketView.swift
////  MarketGo
////
////  Created by ram on 2023/05/06.
////
//
//import Foundation
//import SwiftUI
//
//struct MarketView: View {
//    var body: some View {
//        TabView {
//            MarketInfoView()
//                .tabItem {
//                    Image(systemName: "info.circle")
//                    Text("시장정보")
//                }
//            TouristAttractionsView()
//                .tabItem {
//                    Image(systemName: "mappin.and.ellipse")
//                    Text("주변관광지")
//                }
//            MarketInfoView2()
//                .tabItem {
//                    Image(systemName: "map")
//                    Text("시장맵")
//                }
//        }
//        .navigationBarTitle("동문시장")
//    }
//}
//
//struct MarketInfoView2: View {
//    var body: some View {
//        VStack {
//            Text("위치: 동대문구 회기동 285-2")
//            Text("전화번호: 02-123-4567")
//            Text("설명: 동문시장은 서울의 대표적인 전통 시장 중 하나로, 음식물, 의류, 직물 등 다양한 상품을 판매합니다.")
//        }
//    }
//}
//
//struct TouristAttractionsView: View {
//    var body: some View {
//        List {
//            Text("흥인지문")
//            Text("경동시장")
//            Text("청계천")
//            Text("광장시장")
//            Text("한양도성")
//        }
//        .navigationBarTitle("주변관광지")
//    }
//}
//
//
//
//struct MarketView_Previews: PreviewProvider {
//    static var previews: some View {
//        MarketView()
//    }
//}
