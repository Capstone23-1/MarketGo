//
//  NMapView.swift
//  MarketGo
//
//  Created by ram on 2023/03/31.
//

import SwiftUI
import NMapsMap


struct NMapView: UIViewRepresentable {
    @ObservedObject var lm = LocationManager()
    var cauLocation = CoordinateInfo(lat: 37.505080, lng: 126.9571020)
    
    
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapView = NMFNaverMapView()
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lm.ramLocation?.lat ?? cauLocation.lat, lng: lm.ramLocation?.lng ?? cauLocation.lng))
        
       let marker = NMFMarker()
        marker.position = NMGLatLng(lat: lm.ramLocation?.lat ?? cauLocation.lat, lng: lm.ramLocation?.lng ?? cauLocation.lng)
        marker.mapView = mapView.mapView
        
        
        mapView.mapView.moveCamera(cameraUpdate)
        
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // Nothing to update here
    }
}

struct NMapView_Previews: PreviewProvider {
    static var previews: some View {
        NMapView()
    }
}
