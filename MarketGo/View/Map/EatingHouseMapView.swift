import SwiftUI
import NMapsMap


struct EatingHouseMapView: UIViewRepresentable {
    
    @EnvironmentObject var userModel:UserModel
    @Binding var EatingHouses: [Document]
    @Binding var SelectedEating: Document?
    @ObservedObject var vm:MarketSearchViewModel
    var cauLocation = CoordinateInfo(lat: 37.505080, lng: 126.9571020)
    public let mapView = NMFNaverMapView()
    func makeUIView(context: Context) -> NMFNaverMapView {
        mapView.showLocationButton = true
        mapView.mapView.zoomLevel = 15
        DispatchQueue.main.async {
            if let userLocation = userModel.currentUser {
                let nmg = NMGLatLng(lat: (userLocation.interestMarket?.marketLatitude)! , lng: (userLocation.interestMarket?.marketLongitude)! )
                let cameraUpdate = NMFCameraUpdate(scrollTo: nmg)
                let marketMarker = NMFMarker()
                marketMarker.iconImage = NMF_MARKER_IMAGE_BLACK
                marketMarker.iconTintColor = UIColor.red
                marketMarker.position = nmg
                marketMarker.mapView = mapView.mapView
                marketMarker.mapView?.moveCamera(cameraUpdate)
            }
            for eatingLot in EatingHouses {
                let marker = NMFMarker()
                marker.position = NMGLatLng(lat: Double(eatingLot.y) ?? 0, lng: Double(eatingLot.x) ?? 0)
                marker.mapView = mapView.mapView
                if let selectedEatingLot = SelectedEating, let lat = Double(selectedEatingLot.y), let lng = Double(selectedEatingLot.x) {
                    // 해당 위치로 카메라 이동
                    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
                    mapView.mapView.moveCamera(cameraUpdate)
                }
                marker.touchHandler = { [weak mapView] (overlay: NMFOverlay) -> Bool in
                    if let marker = overlay as? NMFMarker {
                        let cameraUpdate = NMFCameraUpdate(scrollTo: marker.position)
                        mapView?.mapView.moveCamera(cameraUpdate)
                        
                        DispatchQueue.main.async {
                            self.SelectedEating = eatingLot
                            vm.selectedID=eatingLot.id
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
        if let selectedEatingLot = SelectedEating, let lat = Double(selectedEatingLot.y), let lng = Double(selectedEatingLot.x) {
            // 해당 위치로 카메라 이동
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
            mapView.mapView.moveCamera(cameraUpdate)
        }
    }
}
