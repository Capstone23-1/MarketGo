import SwiftUI
import QRCode
struct qrView: View {
    @State private var qrCodeString = "marketgo://98" // QR 생성 데이터
    @State private var info = "싱글탱글생성회"
    @State private var showingAlert = false // 알림창 표시 여부를 결정하는 State
    
    var body: some View {
        VStack {
            Text("자세한 가게 정보를 보려면 QR 코드를 인식해주세요")
                .font(.largeTitle)
            QRCodeView(qrCodeString: $qrCodeString)
            Text(info)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            Button(action: {
                saveImageToCameraRoll()
            }) {
                Text("Save QR Code")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Saved!"), message: Text("Your QR code has been saved to your Photos."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // QR 코드 이미지를 카메라 롤에 저장
    private func saveImageToCameraRoll() {
        var qrCode = QRCode(string: qrCodeString)
        qrCode?.size = CGSize(width: 200, height: 200)
        qrCode?.scale = 1.0
        qrCode?.inputCorrection = .quartile

        if let image = try? qrCode?.image() { // Add 'try?' here
            let uiImage = UIImage(cgImage: image.cgImage!)
            UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
            showingAlert = true // 성공 알림창을 표시
        } else {
            print("Failed to generate QR code image")
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

        if let image = try? qrCode?.image() { // Add 'try?' here
            uiImage = UIImage(cgImage: image.cgImage!)
        } else {
            print("Failed to create QR code image")
        }

        // If the image failed to create, this will just display an empty image
        return Image(uiImage: uiImage ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
    }
}
