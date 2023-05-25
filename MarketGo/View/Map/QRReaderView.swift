import SwiftUI
import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeScannerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController

    @Binding var showingScanner: Bool
    @Binding var qrCodeString: String

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        controller.sourceType = .photoLibrary
        return controller
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Update the view controller if needed
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: QRCodeScannerView

        init(parent: QRCodeScannerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.showingScanner = false

            if let image = info[.originalImage] as? UIImage {
                if let qrCodeString = extractQRCodeString(from: image) {
                    parent.qrCodeString = qrCodeString
                    openURL(with: qrCodeString)
                } else {
                    print("Failed to extract QR code from image")
                }
            }
        }

        private func extractQRCodeString(from image: UIImage) -> String? {
            guard let ciImage = CIImage(image: image) else {
                return nil
            }

            let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
            let features = detector?.features(in: ciImage)

            if let qrCodeFeature = features?.first as? CIQRCodeFeature {
                return qrCodeFeature.messageString
            }

            return nil
        }

        private func openURL(with urlString: String) {
            if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

struct QRCodeReaderView: View {
    @State private var showingScanner = false
    @State private var qrCodeString = ""

    var body: some View {
        VStack {
            Button(action: {
                showingScanner = true
            }) {
                Text("Open QR Code Scanner")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showingScanner) {
                QRCodeScannerView(showingScanner: $showingScanner, qrCodeString: $qrCodeString)
            }
        }
    }
}

struct QRCodeGeneratorView: View {
    @State private var qrCodeString = "marketgo://98"

    var body: some View {
        VStack {
            Image(uiImage: generateQRCodeImage(from: qrCodeString))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)

            Button(action: {
                openURL(with: qrCodeString)
            }) {
                Text("Open QR Code URL")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }

    private func generateQRCodeImage(from string: String) -> UIImage {
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            let context = CIContext()
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark") ?? UIImage()
    }

    private func openURL(with urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
