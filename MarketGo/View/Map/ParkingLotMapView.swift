//
//  NMapView.swift
//  MarketGo
//
//  Created by ram on 2023/03/31.
//

import SwiftUI
import NMapsMap


struct ParkingLotMapView: UIViewRepresentable {
    @ObservedObject var locationManager = LocationManager()
    @Binding var parkingLots: [Document]
    var cauLocation = CoordinateInfo(lat: 37.505080, lng: 126.9571020)
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapView = NMFNaverMapView()
        
        DispatchQueue.main.async {
            if let userLocation = locationManager.userLocation {
                let nmg = NMGLatLng(lat: userLocation.lat ?? 23, lng: userLocation.lng ?? 44)
                let cameraUpdate = NMFCameraUpdate(scrollTo: nmg)
                
                let marketMarker = NMFMarker()
                marketMarker.iconImage = NMF_MARKER_IMAGE_BLACK
                marketMarker.iconTintColor = UIColor.red
                marketMarker.position = nmg
                
                marketMarker.mapView = mapView.mapView
                marketMarker.mapView?.moveCamera(cameraUpdate)
            }
            for parkingLot in parkingLots {
                let marker = NMFMarker()
                
                marker.position = NMGLatLng(lat: Double(parkingLot.y) ?? 0, lng: Double(parkingLot.x) ?? 0)
                marker.mapView = mapView.mapView
            }
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // Do nothing
    }
}



