import SwiftUI
import QRCode

struct qrView: View {
    
    @State private var qrCodeString = "marketgo://98" // QR 생성 데이터
    @State private var info = "싱글탱글생성회"
    
    var body: some View {
        VStack {
            Text("QR 코드 생성기")
                .font(.headline)
            QRCodeView(qrCodeString: $qrCodeString)
            TextField("qrcode 뒤에 넣을꺼", text: $info)
                .padding()
        }
    }
}

struct QRCodeView: View {
    
    @Binding var qrCodeString: String
    
    var body: some View {
        var qrCode = QRCode(string: qrCodeString)
        qrCode?.color = UIColor.black
        qrCode?.backgroundColor = UIColor.white
        qrCode?.size = CGSize(width: 200, height: 200)
        qrCode?.scale = 1.0
        qrCode?.inputCorrection = .quartile

        var uiImage: UIImage?

        do {
            let image = try qrCode?.image() // Now using 'try'
            uiImage = UIImage(cgImage: image!.cgImage!)
        } catch {
            print("Failed to create QR code image: \(error)")
        }

        // If the image failed to create, this will just display an empty image
        return Image(uiImage: uiImage ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
    }
}
