//
//  EatingHouseView.swift
//  MarketGo
//
//  Created by ram on 2023/04/29.
//
import SwiftUI
import NMapsMap

struct EatingHouseView: View {
    @State private var eatingHouses: [Document] = []
    @State private var errorMessage: String?
    @ObservedObject var locationManager = LocationManager()
    @State private var selectedEating: Document?
    @State private var isLoading = false // indicator 추가
    @StateObject var vm = MarketSearchViewModel()
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        VStack {
            if let errorMessage = errorMessage {
                Text(errorMessage)
            } else {
                if isLoading {
                    
                    ProgressView()
                        .scaleEffect(3.0)
                        .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                        .padding()
                    
                } else {
                    
                    EatingHouseMapView(EatingHouses: $eatingHouses, SelectedEating: $selectedEating, vm: vm)
                    EatingHouseList(data: eatingHouses, selectedEating: $selectedEating, vm: vm)
//                    UITableViewWrapper(data: eatingHouses, selected: $selectedEating)

                    
                }
            }
        }
        .onAppear {
            let viewModel = EatingHouseViewModel()
            isLoading = true // 로딩 시작
            viewModel.searchEatingHouse(location: CoordinateInfo(lat: (userModel.currentUser?.interestMarket?.marketLatitude) ?? cauLocation.lat, lng: (userModel.currentUser?.interestMarket?.marketLongitude) ?? cauLocation.lng) , queryKeyword: "맛집") { result in
                switch result {
                    case .success(let parkingLotData):
                        DispatchQueue.main.async {
                            self.eatingHouses = parkingLotData.documents
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



struct EatingHouseView_Previews: PreviewProvider {
    static var previews: some View {
        EatingHouseView()
    }
}
