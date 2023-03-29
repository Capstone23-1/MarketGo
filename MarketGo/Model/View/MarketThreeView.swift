//
//  MarketThreeView.swift
//  MarketGo
//
//  Created by ram on 2023/03/29.
//
//import SwiftUI
//import NMapsMap
//
//struct MarkerThreeView: UIViewRepresentable {
//    // 세 개의 주소를 입력받을 프로퍼티
//    var address1: String
//    var address2: String
//    var address3: String
//
//    func makeUIView(context: Context) -> NMFMapView {
//        let mapView = NMFMapView()
//        mapView.showZoomControls = true
//
//        // 주소를 위도, 경도로 변환하기 위한 객체
//        let geoCoder = NMFGeocoder()
//
//        // 세 개의 주소를 하나씩 변환하여 마커를 표시합니다.
//        geoCoder.requestAddress(address1) { (coord, error) in
//            if error != nil {
//                print("Failed to find address")
//            } else {
//                let marker = NMFMarker(position: coord!.toCLLocationCoordinate2D())
//                marker.mapView = mapView
//            }
//        }
//        geoCoder.requestAddress(address2) { (coord, error) in
//            if error != nil {
//                print("Failed to find address")
//            } else {
//                let marker = NMFMarker(position: coord!.toCLLocationCoordinate2D())
//                marker.mapView = mapView
//            }
//        }
//        geoCoder.requestAddress(address3) { (coord, error) in
//            if error != nil {
//                print("Failed to find address")
//            } else {
//                let marker = NMFMarker(position: coord!.toCLLocationCoordinate2D())
//                marker.mapView = mapView
//            }
//        }
//
//        return mapView
//    }
//
//    func updateUIView(_ mapView: NMFMapView, context: Context) {
//    }
//}
//
//struct MarkerThreeView_Previews: PreviewProvider {
//    static var previews: some View {
//        MarkerThreeView(address1: "서울특별시 강남구 역삼동 736-1", address2: "서울특별시 송파구 잠실동 올림픽로 240", address3: "경기도 성남시 분당구 판교로 242")
//    }
//}
