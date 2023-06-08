import SwiftUI

struct MarketInfoView: View {
    @State private var selectedTab = 0
    @Binding var selectedMarket: MarketOne?
    
    @State private var isLinkActive = false
    @State private var isLoading = false
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var marketModel: MarketModel
    @State private var navigate = false
    @ObservedObject var vm2: MarketSearchViewModel
    
    @StateObject private var vm = MemberProfileEditViewModel()
    func loadMemeber() {
        if let memberInfo = userModel.currentUser {
            vm.memberID = memberInfo.memberID
            vm.memberToken = memberInfo.memberToken ?? ""
            vm.memberName = memberInfo.memberName ?? ""
            vm.interestMarket = memberInfo.interestMarket?.marketID ?? 0
            vm.cartId = memberInfo.cartID?.cartID ?? 0
            vm.storeId = memberInfo.storeID?.storeID ?? 0
            vm.recentLatitude = memberInfo.recentLatitude ?? 0.0
            vm.recentLongitude = memberInfo.recentLongitude ?? 0.0
        }
    }

    
    var NavigationButton: some View {
        Button(action: {
            isLoading = true
            navigate = true
        }) {
            Text("시장 선택")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 250)
                .padding()
                .background(Color.blue)
                .cornerRadius(30)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack {
                    MarketOneMapView(selectedMarket: $selectedMarket)
                        .frame(height: 200)
                    MarketInfoList(marketData: $selectedMarket)
                    
                    NavigationButton
                    
                    NavigationLink(destination: UserMainView(), isActive: $navigate) {
                        EmptyView()
                    }
                    .hidden()
                    
                }
                if isLoading {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .frame(width: 100, height: 100)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .shadow(radius: 10)
                }
            }
            
        }
        .navigationTitle((selectedMarket?.marketName ?? "시장정보"))
        .onAppear {
            isLoading = true
   
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
                print("여기는 마켓인포뷰 :selectedMarket 지도 들어가라 얍")
                print(selectedMarket)
                    Task{
                       
                        userModel.currentUser?.interestMarket = vm2.selectedMarket
//                        self.selectedMarket=userModel.currentUser?.interestMarket
                        print("여기는 마켓인포뷰")
                        print(userModel.currentUser?.interestMarket)
                        
                        if let market = userModel.currentUser?.interestMarket{
                            vm.interestMarket = (market.marketID)
                        }else if let market = marketModel.currentMarket{
                            vm.interestMarket = market.marketID
                        }
                        loadMemeber()
//                        if let market = selectedMarket{
//                            vm.interestMarket = (market.marketID)
//                            userModel.currentUser?.interestMarket = market
//                            marketModel.currentMarket=market
//                        }
                        do {
                            try await vm.updateMemberInfo()
//                            if let market = selectedMarket{
//                                userModel.currentUser?.interestMarket = selectedMarket
//                                marketModel.currentMarket=market
//                            }
//                            if let market = vm.successMemberInfo?.interestMarket{
//                                userModel.currentUser?.interestMarket = market
//                                marketModel.currentMarket=market
//                            }
                            
                        } catch {
                            print("Error while updating member info: \(error)")
                        }
                        
                    }
                    isLoading = false
                    
                
                
                
            }
        }
    }
}

import SwiftUI
import NMapsMap

// TODO: 마커에 캡션 추가해야함
struct MarketOneMapView: UIViewRepresentable {
    
    @ObservedObject var locationManager = LocationManager()
    @Binding var selectedMarket: MarketOne?
    
    var cauLocation = CoordinateInfo(lat: 37.505080, lng: 126.9571020)
    public let mapView = NMFNaverMapView()
    func makeUIView(context: Context) -> NMFNaverMapView {
        mapView.showLocationButton = true
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            print("여기는 마켓원맵뷰")
            print(selectedMarket)
            
            let nmg = NMGLatLng(lat: (selectedMarket?.marketLatitude!) ?? cauLocation.lat , lng: (selectedMarket?.marketLongitude!) ?? cauLocation.lng )
            let cameraUpdate = NMFCameraUpdate(scrollTo: nmg)
            let marketMarker = NMFMarker()
            mapView.showLocationButton = true
            mapView.mapView.zoomLevel = 14
            marketMarker.iconImage = NMF_MARKER_IMAGE_BLACK
            marketMarker.iconTintColor = UIColor.red
            marketMarker.position = nmg
            marketMarker.mapView = mapView.mapView
            marketMarker.mapView?.moveCamera(cameraUpdate)
            
            
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        
    }
}
