import SwiftUI

struct CouponBookView: View {
    @State private var couponCount = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("쿠폰 북")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            ZStack {
                ForEach(1...10, id: \.self) { index in
                    CouponCircleView(filled: index <= couponCount)
                        .offset(x: CGFloat(index * 40 - 200), y: 0)
                }
                
                if couponCount == 10 {
                    Text("성공!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
            }
            
            Spacer()
            
            Button(action: {
                if couponCount < 10 {
                    couponCount += 1
                }
            }) {
                Text("쿠폰 추가")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
    }
}

struct CouponCircleView: View {
    var filled: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: 2)
                .frame(width: 50, height: 50)
            
            if filled {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 40, height: 40)
            }
        }
    }
}

struct CouponBookView_Previews: PreviewProvider {
    static var previews: some View {
        CouponBookView()
    }
}
