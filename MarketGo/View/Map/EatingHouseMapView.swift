import SwiftUI
import NMapsMap


struct EatingHouseMapView: UIViewRepresentable {
    
    @EnvironmentObject var userModel:UserModel
    @Binding var EatingHouses: [Document]
    @Binding var SelectedEating: Document?
    @ObservedObject var vm:MarketSearchViewModel
    var cauLocation = CoordinateInfo(lat: 37.505080, lng: 126.9571020)
    public let mapView = NMFNaverMapView()
   @State var currentInfoWindow: NMFInfoWindow?
    
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
           
            
        }
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        DispatchQueue.main.async {
            let infoWindow = NMFInfoWindow()
            let dataSource = NMFInfoWindowDefaultTextSource.data()

            for eatingLot in EatingHouses {
                let marker = NMFMarker()
                marker.position = NMGLatLng(lat: Double(eatingLot.y) ?? 0, lng: Double(eatingLot.x) ?? 0)
               

                // If the eatingLot is selected, move the camera and open info window
                if let selectedEatingLot = SelectedEating, selectedEatingLot.id == eatingLot.id {
                    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: Double(selectedEatingLot.y) ?? 0, lng: Double(selectedEatingLot.x) ?? 0))
                    uiView.mapView.moveCamera(cameraUpdate)
                    marker.mapView = uiView.mapView

                    
                    self.updateInfoWindow(infoWindow, dataSource, marker, selectedEatingLot.placeName)
                }
            }
        }
    }

    func updateInfoWindow(_ infoWindow: NMFInfoWindow, _ dataSource: NMFInfoWindowDefaultTextSource, _ marker: NMFMarker, _ title: String) {
        dataSource.title = title
        infoWindow.dataSource = dataSource
        infoWindow.open(with: marker)
        
        currentInfoWindow?.close()
        currentInfoWindow = infoWindow
        
        infoWindow.open(with: marker)
    }


}
