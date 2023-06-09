import SwiftUI


struct CouponView: View {
    @StateObject var viewModel = CouponViewModel()
    
    @EnvironmentObject var userModel : UserModel
    @State var isLoading = false
    
    var body: some View {
        ZStack{
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(viewModel.coupons, id: \.couponID) { coupon in
                        if coupon.couponID == 0{
                            if userModel.ten == 1{
                                
                                CouponRow(coupon: coupon)
                                    .frame(height: 200)
                                    
                            }
                        }
                        else{
                            CouponRow(coupon: coupon)
                                .frame(height: 200)
                                
                        }
                    }
                }
                .padding()
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
        .navigationTitle("쿠폰")
        .onAppear {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                Task{
                    if let marketId = userModel.currentUser?.interestMarket?.marketID{
                        viewModel.marketId = marketId
                    }
                    
                    viewModel.fetchCoupons()
                    isLoading=false
                }
                
                
            }
            
        }
    }
}




