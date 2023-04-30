//
//  NMapView.swift
//  MarketGo
//
//  Created by ram on 2023/03/31.
//

import SwiftUI
import NMapsMap


struct MarketMapView: UIViewRepresentable {
    @ObservedObject var selecetedLocation = LocationManager()
    var cauLocation = CoordinateInfo(lat: 37.505080, lng: 126.9571020)

    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapView = NMFNaverMapView()
        mapView.showLocationButton=true
        DispatchQueue.main.async {
            let nmg = NMGLatLng(lat: selecetedLocation.userLocation?.lat ?? cauLocation.lat, lng: selecetedLocation.userLocation?.lng ?? cauLocation.lng)
            let cameraUpdate = NMFCameraUpdate(scrollTo: nmg)

            let marketMarker = NMFMarker()
            marketMarker.position = nmg
            marketMarker.iconImage = NMF_MARKER_IMAGE_BLACK
            marketMarker.iconTintColor = UIColor.blue
            marketMarker.mapView = mapView.mapView

            mapView.mapView.moveCamera(cameraUpdate)
        }

        return mapView
    }
                                                            
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // Nothing to update here
    }
}


struct NMapView_Previews: PreviewProvider {
    static var previews: some View {
        MarketMapView()
    }
}
