import SwiftUI
import Alamofire

struct CouponElement: Codable {
    var couponID: Int?
    var storeID: StoreElement?
    var couponInfo,discount,duration: String?
    
            

    enum CodingKeys: String, CodingKey {
        case couponID = "couponId"
        case storeID = "storeId"
        case couponInfo,discount,duration
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
                            
                            if let discount = coupon.discount {
                                Text("\(discount)원 할인")
                                    .font(.title)
                            }
                            else{
                                Text("")
                                    .font(.title)
                            }
                            
                                
                            Text(" ~ \((coupon.duration) ?? "")")
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
