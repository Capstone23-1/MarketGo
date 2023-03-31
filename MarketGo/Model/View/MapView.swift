//
//  MapView.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import SwiftUI
import NMapsMap

struct MapView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapView = NMFNaverMapView()
        let marker = NMFMarker()
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.541, lng: 126.986))
        
        marker.position = NMGLatLng(lat: 37.541, lng: 126.986)
        marker.mapView = mapView.mapView
        mapView.mapView.moveCamera(cameraUpdate)
        
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // Nothing to update here
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
