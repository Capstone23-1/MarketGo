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
                    if !isLoading {
                        MarketOneMapView(selectedMarket: $selectedMarket)
                            .frame(height: 200)
                    }else{
                        EmptyView()
                            .frame(height: 200)
                    }
                    
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
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                Task {
                    isLoading = true
                    
                    userModel.currentUser?.interestMarket = vm2.selectedMarket
                    
                    if let market = userModel.currentUser?.interestMarket {
                        vm.interestMarket = (market.marketID)
                    } else if let market = marketModel.currentMarket {
                        vm.interestMarket = market.marketID
                    }
                    
                    loadMemeber()
                    
                    do {
                        try await vm.updateMemberInfo()
                    } catch {
                        print("Error while updating member info: \(error)")
                    }
                    
                    isLoading = false
                }
            }
        }
        
    }
}
