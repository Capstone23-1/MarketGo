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
        .background(SnapshotView(showingAlert: $showingAlert))
    }

    // QR 코드 이미지를 카메라 롤에 저장
    private func saveImageToCameraRoll() {
        if let snapshotImage = SnapshotView(showingAlert: $showingAlert).snapshot() {
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

    @Binding var showingAlert: Bool
    private var snapshotImage: UIImage?

    func makeUIView(context: Context) -> UIView {
        return UIView()
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let uiView = uiView as? SnapshotUIView {
            uiView.updateSnapshot(snapshotImage, showingAlert: $showingAlert)
        }
    }

    func snapshot() -> UIImage? {
        guard let uiView = UIApplication.shared.windows.first?.rootViewController?.view else {
            return nil
        }

        UIGraphicsBeginImageContextWithOptions(uiView.bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }

        if let context = UIGraphicsGetCurrentContext() {
            uiView.layer.render(in: context)
            let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
            self.snapshotImage = snapshotImage
            return snapshotImage
        }

        return nil
    }
}

class SnapshotUIView: UIView {
    private var snapshotImageView: UIImageView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSnapshotImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSnapshotImageView()
    }

    private func setupSnapshotImageView() {
        let imageView = UIImageView()
        addSubview(imageView)
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFill
        snapshotImageView = imageView
    }

    func updateSnapshot(_ snapshotImage: UIImage?, showingAlert: Binding<Bool>) {
        snapshotImageView?.image = snapshotImage
        showingAlert.wrappedValue = true
    }
}
