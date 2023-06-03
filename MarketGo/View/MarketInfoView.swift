import SwiftUI

struct MarketInfoView: View {
    @State private var selectedTab = 0
    @Binding var selectedMarket: MarketOne?
    
    @State private var isLinkActive = false
    @State private var isLoading = false
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var marketModel: MarketModel
    @State private var navigate = false
    
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
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack {
                    
                    MarketOneMapView(selectedMarket: $selectedMarket)
                        .frame(height: 200)
                    MarketListView(marketData: $selectedMarket)
                    
                    Button(action: {
                        isLoading = true
                        navigate = true
                        isLoading = false
                    }) {
                        Text("시장 선택")
                            .font(.headline)
                            .foregroundColor(.white)
                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10.0)
                    }
                    
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
                    Task {
                        isLoading = true
                        loadMemeber()
//                        vm.interestMarket = selectedMarket!.marketID
                        do {
                            try await vm.updateMemberInfo()
                            userModel.currentUser?.interestMarket=selectedMarket
                            marketModel.currentMarket=selectedMarket
                            
                        } catch {
                            print("Error while updating member info: \(error)")
                        }
                        isLoading = false
                    }
                }
    }
}
