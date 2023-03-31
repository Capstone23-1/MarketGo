//
//  MapView.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import SwiftUI
import NMapsMap

struct MapView: UIViewRepresentable {
    let coordinates: [Coordinate]
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapView = NMFNaverMapView()
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coordinates[0].lat, lng: coordinates[0].lng))
        
        for coordinate in coordinates {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: coordinate.lat, lng: coordinate.lng)
            marker.mapView = mapView.mapView
        }
        
        mapView.mapView.moveCamera(cameraUpdate)
        
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // Nothing to update here
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinates: [Coordinate(lat: 37.541, lng: 126.986), Coordinate(lat: 37.540, lng: 126.986),Coordinate(lat: 37.540, lng: 126.985)])
    }
}
