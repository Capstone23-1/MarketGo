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
    @State private var selectedParkingLot: Document?
    @State private var isLoading = false // indicator 추가
    @EnvironmentObject var userModel: UserModel
    @StateObject var vm = MarketSearchViewModel()
    
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
                    ParkingLotMapView(ParkingLot: $parkingLots, SelectedParking: $selectedParkingLot, vm: vm)
                    EatingHouseList(data: parkingLots, selectedEating: $selectedParkingLot, vm: vm)
                }
                
            }
        }
        .onAppear {
            let viewModel = ParkingLotViewModel()
            isLoading = true // 로딩 시작
       
            viewModel.searchParkingLot(location: CoordinateInfo(lat: (userModel.currentUser?.interestMarket?.marketLatitude)!, lng: (userModel.currentUser?.interestMarket?.marketLongitude)!) , queryKeyword: "주차장") { result in
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
