import Foundation
import UIKit
import QRCode



// MARK: [색상 hex 값으로 지정]
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}



// MARK: [QR 이미지 뷰 설정]
extension UIImageView {
    convenience init(qrCode: QRCode) {
        self.init(image: qrCode.unsafeImage)
    }
}
import UIKit
import PinLayout
import QRCode


class ViewController: UIViewController {
    
    
    /*
    MARK: [QR 코드 생성 및 레이아웃 설정 필요 사항]
    1. QR 생성 라이브러리 설치 git [Up to Next Major] : https://github.com/dmrschmidt/QRCode
    2. 레이아웃 설정 라이브러리 설치 git [Up to Next Major] : https://github.com/layoutBox/PinLayout
    3. 필요 import :
       - import UIKit
       - import PinLayout
       - import QRCode
    4. 필요 extension : UIColor , UIImageView
    */
    
    
    
    // MARK: [액티비티 메모리 로드 수행 실시]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("")
        print("===============================")
        print("[ViewController >> viewDidLoad() :: 액티비티 메모리 로드 실시]")
        print("===============================")
        print("")
        
        // [기본 뷰 배경 색상 변경 실시 : 검정색]
        self.view.backgroundColor = UIColor.init(rgb: 0x000000).withAlphaComponent(1.0) // 흰색 배경 색상 설정
        
        
        // [QR 코드 속성 정의 실시]
        var qrCode = QRCode(string: "twok1234") // QR 생성 데이터
        //var qrCode = QRCode(url: URL(string: "https://example.com")) // QR 생성 데이터
        qrCode!.color = UIColor.black // QR 코드 선 색상
        qrCode!.backgroundColor = UIColor.white // QR 코드 배경 색상
        qrCode!.size = CGSize(width: 200, height: 200) // QR 코드 사이즈 정의
        qrCode!.scale = 1.0 // scaling
        qrCode!.inputCorrection = .quartile
        
        
        // [이미지 뷰 생성 실시 및 QR 속성 지정 실시]
        let imageView = UIImageView.init(qrCode: qrCode! as QRCode)
        
        
        // [뷰 컨트롤러에 추가 실시]
        self.view.addSubview(imageView)
        
        
        // [위치 퍼센트 사용해 지정 실시]
        imageView.pin.horizontally().top(30%).width(200).justify(.center) // 이미지 뷰 크기도 동일 값 설정 / 가로 중앙 정렬
                
        
        // [크기 퍼센트 사용해 지정 실시]
        imageView.pin.height(200) // 이미지 뷰 크기도 동일 값 설정

        
        // [뷰 컨트롤러에서 제거 실시]
        //imageView.removeFromSuperview()
    }
}
