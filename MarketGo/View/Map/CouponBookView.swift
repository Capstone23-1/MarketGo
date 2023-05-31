import SwiftUI
import Alamofire
import CoreImage
struct CouponBookView: View {
    @State private var imageCate = StoreCategory(categoryID: 3,categoryName: "store")
    @StateObject private var vm = StoreDogamViewModel()
    @State private var inputImage: UIImage?
    
    
    @State private var showingScanner = false
    @State private var qrCodeString = ""
    var body: some View {
        VStack {
            Text("쿠폰북")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            HStack {
                CircleView(storeName: vm.arr[1], isFilled: vm.filledCoupons >= 1)
                CircleView(storeName: vm.arr[2], isFilled: vm.filledCoupons >= 2)
                CircleView(storeName: vm.arr[3], isFilled: vm.filledCoupons >= 3)
                CircleView(storeName: vm.arr[4], isFilled: vm.filledCoupons >= 4)
                CircleView(storeName: vm.arr[5], isFilled: vm.filledCoupons >= 5)
            }
            .padding()
            
            HStack {
                CircleView(storeName: vm.arr[6], isFilled: vm.filledCoupons >= 6)
                CircleView(storeName: vm.arr[7], isFilled: vm.filledCoupons >= 7)
                CircleView(storeName: vm.arr[8], isFilled: vm.filledCoupons >= 8)
                CircleView(storeName: vm.arr[9], isFilled: vm.filledCoupons >= 9)
                CircleView(storeName: vm.arr[10], isFilled: vm.filledCoupons >= 10)
            }
            .padding()
            
            if vm.filledCoupons == 10 {
                Text("축하합니다! 쿠폰을 다 모았습니다.")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
            }
            
            Spacer()
            Button(action: {
                showingScanner = true
                // 쿠폰 추가하는 동작
                
                
                
            }) {
                Text("QR을 입력해주세요")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showingScanner, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
                
            }
            
            
        }
        .alert(isPresented: $vm.showingAlert) {
            Alert(
                title: Text("오류"),
                message: Text("이미 스탬프를 받은 매장입니다."),
                dismissButton: .default(Text("확인"))
            )
        }
    }
        func loadImage() {
            guard let inputImage = inputImage else { return }
            let ciImage = CIImage(image: inputImage)
            
            // QR code scanning
            let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
            let features = detector?.features(in: ciImage!) as? [CIQRCodeFeature]
            let qrCodeString = features?.first?.messageString
            
            if let storeID = qrCodeString {
                // call API to get store details
                vm.fetchStoreDetails(storeID: storeID)
                
                print(storeID)
                
            }
            
            
        }
    }
    class StoreDogamViewModel: ObservableObject {
        @Published var arr: [String] = Array(repeating: "", count: 11)
        @Published var filledCoupons: Int = 0
        @Published var storeElement: StoreElement?
        @Published var showingAlert = false // 새로운 알림 상태 변수
        
        func fetchStoreDetails(storeID: String) {
            let url = "http://3.34.33.15:8080/store/\(storeID)"
            AF.request(url).responseDecodable(of: StoreElement.self) { response in
                switch response.result {
                    case .success(let storeElement):
                        self.storeElement = storeElement
                        print(self.storeElement)
                        if self.filledCoupons < 10 {
                            if self.arr.contains(storeElement.storeName!) {
                                self.showingAlert = true
                            } else {
                                self.filledCoupons += 1
                                self.arr[self.filledCoupons] = storeElement.storeName!
                            }
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                }
            }
        }
    }

struct CouponBookView_Previews: PreviewProvider {
    static var previews: some View {
        CouponBookView()
    }
}
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            picker.dismiss(animated: true)
        }
    }
}
