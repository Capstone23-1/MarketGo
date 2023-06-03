import SwiftUI
import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeScannerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    
    @Binding var showingScanner: Bool
    @Binding var qrCodeString: String
    @Environment(\.openURL) var openURL
    
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
            if let url = URL(string: urlString) {
                DispatchQueue.main.async {
                    self.parent.openURL(url)
                }
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
            
            if !qrCodeString.isEmpty {
                Text("QR Code URL: \(qrCodeString)")
                    .padding()
            }
        }
    }
}
