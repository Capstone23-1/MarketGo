//
//  ContentView2.swift
//  MarketGo
//
//  Created by ram on 2023/04/04.
//

import SwiftUI
import CoreLocation



struct ContentView2: View {
    @ObservedObject var locationManager = LocationManager()

    var body: some View {
        VStack {
            Text("Location: \(locationManager.location?.coordinate.latitude ?? 0), \(locationManager.location?.coordinate.longitude ?? 0)")
            Text("ramLocation: \(locationManager.userLocation?.lat ?? 0), \(locationManager.userLocation?.lng ?? 0)")
            NavigationLink(destination: NMapView()) {
                                Text("화면 넘기기")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10.0)
                            }
                    
                
        }
    }
}


struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
