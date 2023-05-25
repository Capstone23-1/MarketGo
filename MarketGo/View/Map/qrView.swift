import SwiftUI
import QRCode
import UIKit

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
        .background(SnapshotView())
    }

    // QR 코드 이미지를 카메라 롤에 저장
    private func saveImageToCameraRoll() {
        if let snapshotImage = SnapshotView().snapshot(with: Date()) {
            UIImageWriteToSavedPhotosAlbum(snapshotImage, nil, nil, nil)
            showingAlert = true // 성공 알림창을 표시
        } else {
            print("Failed to generate snapshot image")
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

struct SnapshotView: UIViewRepresentable {
    typealias UIViewType = UIView

    func makeUIView(context: Context) -> UIView {
        return UIView()
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func snapshot(with date: Date) -> UIImage? {
        guard let uiView = UIApplication.shared.windows.first?.rootViewController?.view else {
            return nil
        }

        UIGraphicsBeginImageContextWithOptions(uiView.bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }

        if let context = UIGraphicsGetCurrentContext() {
            uiView.layer.render(in: context)

            let timestampText = formattedTimestamp(from: date) // 현재 시간을 형식화한 텍스트
            let textRect = CGRect(x: 10, y: 10, width: 100, height: 20) // 텍스트 위치와 크기
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.red
            ]
            timestampText.draw(in: textRect, withAttributes: attributes) // 텍스트를 사진에 그림

            return UIGraphicsGetImageFromCurrentImageContext()
        }

        return nil
    }

    // 현재 시간을 형식화한 텍스트를 반환하는 함수
    private func formattedTimestamp(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
}
