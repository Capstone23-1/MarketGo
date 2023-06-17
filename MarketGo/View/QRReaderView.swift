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
        controller.sourceType = .camera
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
                    //                    openURL(with: qrCodeString)
                } else {
                    print("QR 코드 인식에 실패하였습니다.")
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
        //
        //        private func openURL(with urlString: String) {
        //            if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
        //                UIApplication.shared.open(url, options: [:], completionHandler: nil)
        //            }
        //        }
    }
}
struct QRCodeReaderView: View {
    @State private var showingScanner = false
    @State private var qrCodeString = ""
    @State private var isLoading = false
    @State private var fetchedStore: StoreElement?
    @StateObject var userModel = UserModel()
    @StateObject private var storePost = StorePostViewModel()
    @State private var moveStoreView = false
    @State private var showingInvalidQRCodeAlert = false // 추가: 알림을 표시하는 상태
    
    var body: some View {
        
        if moveStoreView {
            if isLoading {
                ProgressView("Loading...")
            } else if let store = fetchedStore {
                StoreView(store: store)
            }
        }
        else {
            Button(action: {
                showingScanner = true
            }) {
                VStack {
                    Text("상점 QR 코드를 찍어주세요")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showingScanner) {
                    QRCodeScannerView(showingScanner: $showingScanner, qrCodeString: $qrCodeString)
                }
                .onChange(of: qrCodeString) { newValue in
                    // When the QR code string changes, handle the URL
                    handleQRCodeString(newValue)
                }
                .alert(isPresented: $showingInvalidQRCodeAlert) { // 추가: 알림을 표시
                    Alert(title: Text("오류"),
                          message: Text("올바른 QR 코드를 입력해주세요."),
                          dismissButton: .default(Text("확인")))
                }
            }
        }
    }
    
    // A function to handle the QR code string
    private func handleQRCodeString(_ qrCodeString: String) {
        guard !qrCodeString.isEmpty,
              let url = URL(string: qrCodeString),
              let host = url.host else {
            showingInvalidQRCodeAlert = true // 추가: 알림 상태를 true로 설정
            return
        }
        
        // Run the async task
        Task {
            do {
                let fetchedStore = try await Config().fetchStoreById(host)
                await MainActor.run {
                    self.fetchedStore = fetchedStore
                    self.isLoading = false
                    self.moveStoreView = true
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                }
                print("Error fetching store: \(error)")
            }
        }
    }
}



