import SwiftUI
import Alamofire

struct CouponElement: Codable {
    var couponID: Int?
    var storeID: StoreElement?
    var couponInfo: String?
    

    enum CodingKeys: String, CodingKey {
        case couponID = "couponId"
        case storeID = "storeId"
        case couponInfo
    }
}
import SwiftUI

struct CouponUseView: View {
    var coupon: CouponElement
    @State private var isAlertPresented = false
    @State var isCouponUsed = false
    @EnvironmentObject var userModel : UserModel
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                Text("\(coupon.storeID?.storeName ?? "")")
                    .font(.title3)
                
                Text("10% 할인 쿠폰")
                    .font(.title)
                    .foregroundColor(.black)
                
                if let info = coupon.couponInfo {
                    Text(" ~ \(coupon.couponInfo ?? "") 까지")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                
                Text("주의 : 만원 이상 구매시 사용 가능")
                    .font(.footnote)
                    .foregroundColor(.red)
            }
            .padding()
            .frame(maxWidth: .infinity,maxHeight:300)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            
            Button(action: {
                isAlertPresented = true
                userModel.cState[coupon.couponID ?? 0] = true
            }) {
                Text("사용하기")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isCouponUsed ? Color.gray : Color.blue)
                    .cornerRadius(10)
            }
            .disabled(isCouponUsed)
            .alert(isPresented: $isAlertPresented) {
                Alert(
                    title: Text("쿠폰 사용"),
                    message: Text("쿠폰을 사용하시겠습니까?"),
                    primaryButton: .default(Text("OK"), action: {
                        isCouponUsed = true
                    }),
                    secondaryButton: .cancel()
                )
            }
            .onAppear{
                isCouponUsed = userModel.cState[coupon.couponID ?? 0] ?? false
            }
        }
        .padding()
        .navigationTitle("쿠폰 사용")
    }
}



struct CouponView: View {
    @StateObject var viewModel = CouponViewModel()
    @State private var selectedCoupon: CouponElement? = nil
    @EnvironmentObject var userModel : UserModel
    @State var isLoading = false
    
    var body: some View {
        ZStack{
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(viewModel.coupons, id: \.couponID) { coupon in
                        CouponRow(coupon: coupon)
                            .frame(height: 200)
                            .onTapGesture {
                                selectedCoupon = coupon
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

struct CouponRow: View {
    var coupon: CouponElement
    
    var body: some View {
        NavigationLink(destination: CouponUseView(coupon: coupon)) {
            
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\((coupon.storeID?.storeName) ?? "" )")
                                .font(.title2)
                            
                            Text("10% 할인")
                                .font(.title)
                                
                            Text("유효기간 : ~ \((coupon.couponInfo) ?? "")")
                                .font(.footnote)
                                .foregroundColor(.gray)
                       
                        }
                        .padding()
                    
                
            }

            .padding()
        }
    }
}

class CouponViewModel: ObservableObject {
    @Published var coupons: [CouponElement] = []
    @Published var marketId : Int?
    
    func fetchCoupons() {
        var url = ""
        if let marketId = marketId {
            url = "http://3.34.33.15:8080/coupon/marketId/\(marketId)"
        }
        else{
            url = "http://3.34.33.15:8080/coupon/all"
        }
        AF.request(url)
            .validate()
            .responseDecodable(of: [CouponElement].self) { response in
                guard let coupons = response.value else { return }
                self.coupons = coupons
            }
    }
}
