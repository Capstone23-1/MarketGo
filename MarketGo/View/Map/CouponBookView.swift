import SwiftUI

struct CouponBookView: View {
    @State private var filledCoupons: Int = 0
    @State var arr: [String] = Array(repeating: "", count: 11)
    @State private var showingScanner = false
    @State private var qrCodeString = ""
    var body: some View {
        VStack {
            Text("쿠폰북")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            HStack {
                CircleView(storeName: arr[1], isFilled: filledCoupons >= 1)
                CircleView(storeName: arr[2], isFilled: filledCoupons >= 2)
                CircleView(storeName: arr[3], isFilled: filledCoupons >= 3)
                CircleView(storeName: arr[4], isFilled: filledCoupons >= 4)
                CircleView(storeName: arr[5], isFilled: filledCoupons >= 5)
            }
            .padding()
            
            HStack {
                CircleView(storeName: arr[6], isFilled: filledCoupons >= 6)
                CircleView(storeName: arr[7], isFilled: filledCoupons >= 7)
                CircleView(storeName: arr[8], isFilled: filledCoupons >= 8)
                CircleView(storeName: arr[9], isFilled: filledCoupons >= 9)
                CircleView(storeName: arr[10], isFilled: filledCoupons >= 10)
            }
            .padding()
            
            if filledCoupons == 10 {
                Text("축하합니다! 쿠폰을 다 모았습니다.")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
            }
            
            Spacer()
            Button(action: {
                showingScanner = true
            }) {
                Text("QR을 입력해주세요")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showingScanner) {
//                QRCodeScannerView(showingScanner: $showingScanner, qrCodeString: $qrCodeString)
            }
            
            
            //            Button(action: {
            //                
            //                // 쿠폰 추가하는 동작
            //                if filledCoupons < 10 {
            //                    filledCoupons += 1
            //                    arr[filledCoupons]="storeName"
            //                }
            //            }) {
            //                Text("쿠폰 추가하기")
            //                    .foregroundColor(.white)
            //                    .padding()
            //                    .background(Color.blue)
            //                    .cornerRadius(10)
            //            }
            //            .padding()
            //        }
        }
    }
}

struct CouponBookView_Previews: PreviewProvider {
    static var previews: some View {
        CouponBookView()
    }
}
