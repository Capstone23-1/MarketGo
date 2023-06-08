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
                
                if !isLoading {
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
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            isLoading = true
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
                    } else if let market = marketModel.currentMarket {
                        vm.interestMarket = market.marketID!
                        userModel.currentUser?.interestMarket = market
                    }
                    
                    
                    loadMemeber()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.4){
                        Task {
                            userModel.currentUser?.interestMarket = (vm2.selectedMarket)!
                            do {
                                try await vm.updateMemberInfo()
                            } catch {
                                print("Error while updating member info: \(error)")
                            }
                        }}
                    isLoading = false
                }
            }
        }
        
    }
}
