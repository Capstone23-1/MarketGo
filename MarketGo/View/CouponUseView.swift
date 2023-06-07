import SwiftUI
import Alamofire
struct CouponUseView: View {
    var coupon: CouponElement
    @State private var isAlertPresented = false
    @State var isCouponUsed = false
    @EnvironmentObject var userModel : UserModel
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                Text("\(coupon.storeID?.storeName ?? "")")
                    .font(.body)
                    
                
                
                    
                Text((coupon.discount)!)
                            .font(.title)
                            .foregroundColor(.black)
                    
                  
               
                
                
                if let info = coupon.duration {
                    Text(" ~ \(info ) 까지")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                
                Text("주의  \((coupon.couponInfo)!)")
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
