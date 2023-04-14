//
//  ParkingLotView.swift
//  MarketGo
//
//  Created by ram on 2023/04/14.
//

import SwiftUI
struct ParkingLotView: View {
    @State private var parkingLots: [Document] = []
    @State private var errorMessage: String?
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            if let errorMessage = errorMessage {
                Text(errorMessage)
            } else {
                if parkingLots.isEmpty {
                    Text("주차장 검색 결과가 없습니다.")
                } else {
                    ParkingLotMapView(parkingLots: $parkingLots)
                    List(parkingLots, id: \.distance) { parkingLot in
                        Text("\(parkingLot.placeName)   \(parkingLot.distance)m")
                        
                    }
                }
            }
        }
        .onAppear {
            let viewModel = ParkingLotViewModel()
            viewModel.searchParkingLot(location: locationManager.userLocation ?? cauLocation, queryKeyword: "주차장") { result in
                switch result {
                case .success(let parkingLotData):
                    DispatchQueue.main.async {
                        self.parkingLots = parkingLotData.documents
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}




struct ParkingLotView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingLotView()
    }
}
