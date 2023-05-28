import SwiftUI
import QRCode
struct QRCodeView: View {
    
    @State var qrCodeString = "gkgkgkgk"
    
    var body: some View {
        VStack {
            Button(action: {
                if let image = generateQRCodeWithText(qrCodeString, text: "싱싱사철회") {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            }) {
                Text("Save to Gallery")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
    func generateQRCodeWithText(_ qrCodeString: String, text: String) -> UIImage? {
        var qrCode = QRCode(string: qrCodeString)
        qrCode?.color = UIColor.black
        qrCode?.backgroundColor = UIColor.white
        qrCode?.size = CGSize(width: 200, height: 200)
        qrCode?.scale = 1.0
        qrCode?.inputCorrection = .quartile

        guard let qrImage = try? qrCode?.image(),
            let textImage = text.asImage() else {
            print("Failed to create images")
            return nil
        }

        let finalImage = qrImage.combined(with: textImage)
        return finalImage
    }

}
extension String {
    func asImage(font: UIFont = UIFont.systemFont(ofSize: 16)) -> UIImage? {
        let size = self.size(withAttributes: [NSAttributedString.Key.font: font])
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: CGRect(origin: .zero, size: size), withAttributes: [NSAttributedString.Key.font: font])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
extension UIImage {
    func combined(with image: UIImage) -> UIImage? {
        let size = CGSize(width: max(self.size.width, image.size.width), height: self.size.height + image.size.height)
        UIGraphicsBeginImageContext(size)

        self.draw(in: CGRect(origin: CGPoint(x: (size.width - self.size.width)/2, y: 0), size: self.size))
        image.draw(in: CGRect(origin: CGPoint(x: (size.width - image.size.width)/2, y: self.size.height), size: image.size))

        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage
    }
}
