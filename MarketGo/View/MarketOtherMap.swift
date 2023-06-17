import SwiftUI
import NMapsMap

struct MarketOtherMap: UIViewRepresentable {
    
    
    var latitude: Double
    var longitude: Double

    public let mapView = NMFNaverMapView()

    func makeUIView(context: Context) -> NMFNaverMapView {
        
        mapView.showLocationButton = true
        
        let nmg = NMGLatLng(lat: latitude, lng: longitude)
        let cameraUpdate = NMFCameraUpdate(scrollTo: nmg)
        let marketMarker = NMFMarker()
            
        mapView.mapView.zoomLevel = 14
        marketMarker.iconImage = NMF_MARKER_IMAGE_BLACK
        marketMarker.iconTintColor = UIColor.red
        marketMarker.position = nmg
        marketMarker.mapView = mapView.mapView
        marketMarker.mapView?.moveCamera(cameraUpdate)
   
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        
    }
}
import SwiftUI
import NMapsMap

struct MarketOneMapContainerView: View {
    
    var latitude: Double
    var longitude: Double
    
    var body: some View {
        
            MarketOtherMap(latitude: latitude, longitude: longitude)
                .frame(height: 200)
        
    }
}
