//
//  MarketOneMapView.swift
//  MarketGo
//
//  Created by ram on 2023/05/06.
//

import SwiftUI
import NMapsMap

// TODO: 마커에 캡션 추가해야함
struct MarketOneMapView: UIViewRepresentable {
    
    @ObservedObject var locationManager = LocationManager()
    @Binding var selectedMarket: MarketOne?
    var cauLocation = CoordinateInfo(lat: 37.505080, lng: 126.9571020)
    public let mapView = NMFNaverMapView()
    func makeUIView(context: Context) -> NMFNaverMapView {
        mapView.showLocationButton = true
        
        DispatchQueue.main.async {
            
            let nmg = NMGLatLng(lat: (selectedMarket?.marketLatitude!) ?? cauLocation.lat , lng: (selectedMarket?.marketLongitude!) ?? cauLocation.lng )
            let cameraUpdate = NMFCameraUpdate(scrollTo: nmg)
            let marketMarker = NMFMarker()
            mapView.mapView.zoomLevel = 14
            marketMarker.iconImage = NMF_MARKER_IMAGE_BLACK
            marketMarker.iconTintColor = UIColor.red
            marketMarker.position = nmg
            marketMarker.mapView = mapView.mapView
            marketMarker.mapView?.moveCamera(cameraUpdate)
            
        }
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        
    }
}
