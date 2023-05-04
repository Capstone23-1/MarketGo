//
//  NMapView.swift
//  MarketGo
//
//  Created by ram on 2023/03/31.
//

import SwiftUI
import NMapsMap


struct MarketMapView: UIViewRepresentable {
    
    @ObservedObject var locationManager = LocationManager()
    @Binding var marketList: [Document]
    @Binding var selectedMarket: Document?
    var cauLocation = CoordinateInfo(lat: 37.505080, lng: 126.9571020)
    public let mapView = NMFNaverMapView()
    func makeUIView(context: Context) -> NMFNaverMapView {
        mapView.showLocationButton = true
        
        DispatchQueue.main.async {
            if let userLocation = locationManager.userLocation {
                let nmg = NMGLatLng(lat: userLocation.lat , lng: userLocation.lng )
                let cameraUpdate = NMFCameraUpdate(scrollTo: nmg)
                let marketMarker = NMFMarker()
                mapView.mapView.zoomLevel = 14
                marketMarker.iconImage = NMF_MARKER_IMAGE_BLACK
                marketMarker.iconTintColor = UIColor.red
                marketMarker.position = nmg
                marketMarker.mapView = mapView.mapView
                marketMarker.mapView?.moveCamera(cameraUpdate)
            }
            for market in marketList {
                let marker = NMFMarker()
                marker.position = NMGLatLng(lat: Double(market.y) ?? 0, lng: Double(market.x) ?? 0)
                marker.mapView = mapView.mapView
                if let selectedMarket = selectedMarket, let lat = Double(selectedMarket.y), let lng = Double(selectedMarket.x) {
                    // 해당 위치로 카메라 이동
                    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
                    mapView.mapView.moveCamera(cameraUpdate)
                }
                marker.touchHandler = { [weak mapView] (overlay: NMFOverlay) -> Bool in
                    if let marker = overlay as? NMFMarker {
                        let cameraUpdate = NMFCameraUpdate(scrollTo: marker.position)
                        mapView?.mapView.moveCamera(cameraUpdate)
                        DispatchQueue.main.async {
                            self.selectedMarket = market
                        }
                        DispatchQueue.main.async {
                            if let index = self.marketList.firstIndex(where: { $0.id == market.id }) {
                                self.selectedMarket = self.marketList[index]
                            }
                        }
                        
                    }
                    return true
                }
            }
        }
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // 선택된 주차장이 있고, 해당 주차장의 위치 정보가 있는 경우
        if let selectedMarket = selectedMarket, let lat = Double(selectedMarket.y), let lng = Double(selectedMarket.x) {
            // 해당 위치로 카메라 이동
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
            mapView.mapView.moveCamera(cameraUpdate)
        }
    }
}
