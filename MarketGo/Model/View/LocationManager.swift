//
//  LocationManager.swift
//  MarketGo
//
//  Created by ram on 2023/04/04.
//

import Foundation
import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()

    @Published var location: CLLocation? = nil
    @Published var locationStatus: CLAuthorizationStatus? = nil
    @Published var ramLocation: CoordinateInfo? = nil
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        
        
        
        // CLLocation 객체를 CoordinateInfo 구조체로 변환하여 저장
        self.ramLocation = CoordinateInfo(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
    }
    
}
