import SwiftUI
import QRCode

struct DogamQRGenerateView: View {
    @EnvironmentObject var userViewModel: UserModel
    @State private var qrCodeString = ""
    @State private var showingAlert = false

    var body: some View {
        VStack {
            generateQRAndTextImage()
        }
        .onAppear {
            qrCodeString = String(describing: (userViewModel.currentUser?.storeID?.storeID)!)
            text = userViewModel.currentUser?.storeID?.storeName ?? ""
            print(qrCodeString)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("사진첩에 저장"), message: Text("QR 코드는 갤러리에 저장됐습니다."), dismissButton: .default(Text("OK")))
        }
    }
    
    @State private var text: String = ""

    private func generateQRAndTextImage() -> some View {
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
        
        let texthigh = "가게 도감을 모으기 위한 QR입니다."
        // Create texthigh image
        let texthighFont = UIFont(name: "Helvetica", size: 20)!
        let texthighAttributes: [NSAttributedString.Key: Any] = [.font: texthighFont]
        let texthighSize = texthigh.size(withAttributes: texthighAttributes)
        UIGraphicsBeginImageContextWithOptions(texthighSize, false, 0.0)
        texthigh.draw(at: .zero, withAttributes: texthighAttributes)
        let texthighImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let text = userViewModel.currentUser?.storeID?.storeName
        // Create text image
        let textFont = UIFont(name: "Helvetica-Bold", size: 20)!
        let textAttributes: [NSAttributedString.Key: Any] = [.font: textFont]
        let textSize = text!.size(withAttributes: textAttributes)
        UIGraphicsBeginImageContextWithOptions(textSize, false, 0.0)
        text!.draw(at: .zero, withAttributes: textAttributes)
        let textImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Combine QR code, texthigh, and text images
        let finalSize = CGSize(width: max(uiImage!.size.width, textImage!.size.width, texthighImage!.size.width), height: uiImage!.size.height + textImage!.size.height + texthighImage!.size.height)
        UIGraphicsBeginImageContextWithOptions(finalSize, false, 0.0)
        texthighImage!.draw(at: CGPoint(x: (finalSize.width - texthighSize.width) / 2, y: 0))
        uiImage!.draw(at: CGPoint(x: (finalSize.width - uiImage!.size.width) / 2, y: texthighImage!.size.height))
        textImage!.draw(at: CGPoint(x: (finalSize.width - textSize.width) / 2, y: uiImage!.size.height + texthighImage!.size.height))
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Save to photo library
        let button = Button("사진첩에 저장") {
            UIImageWriteToSavedPhotosAlbum(combinedImage!, nil, nil, nil)
            self.showingAlert = true
        }
        
        // If the image failed to create, this will just display an empty image
        return VStack {
            Image(uiImage: combinedImage ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 400)
            button
        }
    }
}
