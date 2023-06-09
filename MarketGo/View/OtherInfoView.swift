import SwiftUI

struct OtherInfoView: View {
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
                    if !isLoading {
                        if let market = userModel.currentUser?.interestMarket{
                            if let lat = market.marketLatitude,let lng=market.marketLongitude{
                                MarketOneMapContainerView(latitude: Double(lat), longitude: Double(lng))
                            }
                            else{
                                MarketOneMapContainerView(latitude: cauLocation.lat, longitude: cauLocation.lng)
                            }
                        }
                        else{
                            MarketOneMapContainerView(latitude: cauLocation.lat, longitude: cauLocation.lng)
                        }
                        
                        
                        MarketInfoList(marketData: $selectedMarket)
                        
                        NavigationButton
                        
                        NavigationLink(destination: UserMainView(), isActive: $navigate) {
                            EmptyView()
                        }
                        .hidden()
                    }else{
                        EmptyView()
                            .frame(height: 200)
                    }
                    
                    
                }
                
                if isLoading {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .frame(width: 100, height: 100)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
                
            }
            
        }
        .navigationTitle((selectedMarket?.marketName ?? "시장정보"))
        .onAppear {
            isLoading = true
            userModel.marketName=(selectedMarket?.marketName)!
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                Task {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                        Task {
                            vm2.fetchMarketData(marketName: userModel.marketName)
                        }}
                    
                    
                    print("userModel.currentUser.interestMarket=")
                    print(userModel.currentUser?.interestMarket)
                    print("vm2.선택된마켓")
                    print(vm2.selectedMarket)
                    if let market = vm2.selectedMarket {
                        vm.interestMarket = (market.marketID!)
                        userModel.currentUser?.interestMarket = market
                    } else if let market = vm2.selectedMarket {
                        vm.interestMarket = market.marketID!
                        userModel.currentUser?.interestMarket = market
                    }
                    
                    
                    loadMemeber()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.4){
                        Task {
                            if let market = vm2.selectedMarket {
                                vm.interestMarket = (market.marketID!)
                                userModel.currentUser?.interestMarket = market
                            } else if let market = vm2.selectedMarket {
                                vm.interestMarket = market.marketID!
                                userModel.currentUser?.interestMarket = market
                            }
                            do {
                                try await vm.updateMemberInfo()
                            } catch {
                                print("Error while updating member info: \(error)")
                            }
                            isLoading = false
                        }}
                    
                }
            }
        }
        
    }
}
