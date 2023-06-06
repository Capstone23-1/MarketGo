import SwiftUI

struct CouponGeneratorView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = CouponGeneratorViewModel()
    @EnvironmentObject var userModel:UserModel
    
    var body: some View {
        VStack {
            DatePicker("쿠폰 만료일 지정", selection: $viewModel.expirationDate, displayedComponents: [.date])
                .padding()
       
            Button(action: {
                viewModel.generateCoupon()
            }) {
                Text("발행")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            .onAppear{
                viewModel.storeId = (userModel.currentUser?.storeID?.storeID)!
            }
            .alert(isPresented: $viewModel.showAlert) {
                if viewModel.isCouponGenerated {
                    return Alert(title: Text("성공"), message: Text("쿠폰 발행에 성공했습니다."), dismissButton: .default(Text("OK"), action: {
                        presentationMode.wrappedValue.dismiss()
                    }))
                } else {
                    return Alert(title: Text("실패"), message: Text("쿠폰 발행에 실패했습니다."), dismissButton: .default(Text("OK")))
                }
            }
        }
        .navigationTitle("가게별 쿠폰 생성")
    }
}
import Alamofire
import Combine

class CouponGeneratorViewModel: ObservableObject {
    @Published var expirationDate: Date = Date() {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy/MM/dd"
            couponInfo = dateFormatter.string(from: expirationDate)
        }
    }
    @Published var storeId: Int = 100
    @Published var couponInfo: String = ""
    @Published var isCouponGenerated: Bool = false
    @Published var showAlert: Bool = false
    
    func generateCoupon() {
        let url = "http://3.34.33.15:8080/coupon"
        let parameters: [String: Any] = ["storeId": storeId, "couponInfo": couponInfo]
        
        AF.request(url, method: .post, parameters: parameters)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    print("Coupon generated successfully!")
                    self.isCouponGenerated = true
                    self.showAlert = true
                case let .failure(error):
                    print("Error generating coupon: \(error)")
                    self.isCouponGenerated = false
                    self.showAlert = true
                }
            }
    }
}
