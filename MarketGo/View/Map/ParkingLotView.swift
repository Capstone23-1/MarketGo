//
//  ParkingLotView.swift
//  MarketGo
//
//  Created by ram on 2023/04/14.
//

import SwiftUI
import NMapsMap

struct ParkingLotView: View {
    @State private var parkingLots: [Document] = []
    @State private var errorMessage: String?
    @ObservedObject var locationManager = LocationManager()
    @State private var selectedParkingLot: Document?
    @State private var isLoading = false // indicator 추가
    
    var body: some View {
        VStack {
            if let errorMessage = errorMessage {
                Text(errorMessage)
            } else {
                if isLoading {
                    ProgressView()
                        .scaleEffect(3.0)
                        .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                        .padding()

                } else {
                    ParkingLotMapView(parkingLots: $parkingLots, selectedParkingLot: $selectedParkingLot)
                    List(parkingLots, id: \.distance) { parkingLot in
                        VStack(alignment: .leading) {
                            Text(parkingLot.placeName)
                                .font(.headline)
                            Text("\(parkingLot.distance)m")
                                .font(.subheadline)
                        }
                        .onTapGesture {
                            selectedParkingLot = parkingLot
                            print(selectedParkingLot!)
                        }
                        .foregroundColor(selectedParkingLot?.id == parkingLot.id ? .blue : .primary)
                    }
                }
            }
        }
        .onAppear {
            let viewModel = ParkingLotViewModel()
            isLoading = true // 로딩 시작
            viewModel.searchParkingLot(location: locationManager.userLocation ?? cauLocation, queryKeyword: "주차장") { result in
                switch result {
                    case .success(let parkingLotData):
                        DispatchQueue.main.async {
                            self.parkingLots = parkingLotData.documents
                            isLoading = false // 로딩 종료
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.errorMessage = error.localizedDescription
                            isLoading = false // 로딩 종료
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
