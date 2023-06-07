import SwiftUI
import Alamofire
import CoreImage
struct DogamBookView: View {
    @StateObject private var vm = StoreDogamViewModel()
    @State private var inputImage: UIImage?
    @State private var showingInvalidQRAlert = false
    @EnvironmentObject var userModel: UserModel
    @State private var showingScanner = false
    @State private var qrCodeString = ""
    var body: some View {
        VStack {
            Text("MarketGo 도감")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            HStack {
                ForEach(0..<5) { index in
                    CircleView(storeName: vm.arr[index], isFilled: vm.filledCoupons >= index+1)
                }
            }
            .padding()
            
            HStack {
                ForEach(5..<10) { index in
                    CircleView(storeName: vm.arr[index], isFilled: vm.filledCoupons >= index+1)
                }
            }
            .padding()
            
            
            if vm.filledCoupons >= 10 {
                Text("축하합니다! 쿠폰을 다 모았습니다.")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
                    .onAppear {
                        userModel.ten = true
                    }
                
            }
            
            
            Button(action: {
                showingScanner = true
                // 쿠폰 추가하는 동작
            }) {
                Text("QR을 입력해주세요")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .sheet(isPresented: $showingScanner, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
                
            }
        }
        .onAppear {
            vm.storeIDs[0]=""
            vm.getMemberIndexById(memberID:String(describing: (userModel.currentUser?.memberID)!))
        }
        .alert(isPresented: $vm.showingAlert) {
            Alert(
                title: Text("오류"),
                message: Text("이미 스탬프를 받은 매장입니다."),
                dismissButton: .default(Text("확인"))
            )
        }
        .alert(isPresented: $showingInvalidQRAlert) {
            Alert(
                title: Text("오류"),
                message: Text("마켓고 도감 이벤트 QR을 입력해주세요"),
                dismissButton: .default(Text("확인"))
            )
        }
        Spacer()
    }
    func loadImage() {
        vm.memberID = String(describing: (userModel.currentUser?.memberID)!)
        
        guard let inputImage = inputImage else { return }
        let ciImage = CIImage(image: inputImage)
        
        // QR code scanning
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        let features = detector?.features(in: ciImage!) as? [CIQRCodeFeature]
        let qrCodeString = features?.first?.messageString
        
        if let storeID = qrCodeString {
            // Check if the scanned string is a number
            if Int(storeID) != nil {
                // call API to get store details
                vm.getStoreInfoById(storeID: storeID)
//                print(storeID)
            } else {
                // Show alert if the scanned string is not a number
                showingInvalidQRAlert = true
            }
        } else {
            // Show alert if no QR code is found
            showingInvalidQRAlert = true
        }
    }
    
}
class StoreDogamViewModel: ObservableObject {
    @Published var arr: [String] = Array(repeating: "", count: 11)
    @Published var storeIDs: [String] = Array(repeating: "", count: 11)   // 스캔한 QR 코드를 저장할 배열
    
    @Published var filledCoupons: Int = 0
    @Published var storeElement: StoreElement?
    @Published var showingAlert = false // 새로운 알림 상태 변수
    @Published var memberID = ""
    @Published var indexID = ""
    @Published var dogamIndex: IndexInfo?
    func putMemeberIndex() {
        // storeIDs 배열에서 첫 10개 아이템만 가져옴
        let first10IDs = Array(self.storeIDs.prefix(11))
        
        // baseURL
        var url = "http://3.34.33.15:8080/marketIndex/\(indexID)?memberId=\(self.memberID)"
        
        // 각 스토어ID를 쿼리 문자열에 추가
        for i in 0...9 {
            
            var storeId = "1"// Default to "0"
            if i < 10 {
                if first10IDs[i].count >= 1 {
                    storeId = first10IDs[i]
                }
                else {
                    storeId = "0"
                    
                }
                
//                print(String(describing:first10IDs[i].count)+"이것은 \(i)번째 count"+storeId)
                url += "&storeId\(i+1)=\(storeId)"
            }
            
        }
        
        
        // PUT 요청
        AF.request(url, method: .put).response { response in
            
            print("put 메서드")
        }
        
//        print(first10IDs)
    }
    
    func getMemberIndexById(memberID: String) {
        let url =  "http://3.34.33.15:8080/marketIndex/memberId/\(memberID)"
//        print(url)
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                    case .success(let data):
//                        print(data)
                        if let data = data {
                            if let indexInfo = try? JSONDecoder().decode(IndexInfo.self, from: data) {
//                                print("IndexInfo: \(indexInfo)")
                                self.indexID=String(describing: (indexInfo.indexID)!)
//                                print(indexInfo)
                                let storeIds = [indexInfo.storeId1, indexInfo.storeId2, indexInfo.storeId3, indexInfo.storeId4, indexInfo.storeId5, indexInfo.storeId6, indexInfo.storeId7, indexInfo.storeId8, indexInfo.storeId9, indexInfo.storeId10]
                                self.indexID = String(describing: (indexInfo.indexID)!)

                                for i in 0..<10 {
                                    if storeIds[i]?.storeID == 0 {
                                        self.arr[i] = ""
                                        self.storeIDs[i] = "0"
                                    } else {
                                        self.arr[i] = storeIds[i]?.storeName ?? ""
                                        self.storeIDs[i] = String(describing: ((storeIds[i]?.storeID)!))
                                        self.filledCoupons+=1
                                        
                                    }
//                                    print("i=\(String(describing:i)) arr[i]"+self.arr[i]+"storeIDS[i]="+self.storeIDs[i])
                                }
                            }
//                            print(self.arr)
//                            print(self.storeIDs)
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                }
            }
    }
    //쿠폰에 가져올 store 인포 가져오기
    func getStoreInfoById(storeID: String) {
        let url = "http://3.34.33.15:8080/store/\(storeID)"
        AF.request(url).responseDecodable(of: StoreElement.self) { response in
            switch response.result {
                case .success(let storeElement):
                    self.storeElement = storeElement
                    if self.filledCoupons < 10 {
                        if self.arr.contains(storeElement.storeName!) {
                            self.showingAlert = true
                        } else {
                          
                            self.arr[self.filledCoupons] = storeElement.storeName!
                            self.storeIDs[self.filledCoupons]=String(describing: (storeElement.storeID)!)   // 스캔한 QR 코드를 배열에 추가
                            self.putMemeberIndex()
                            self.filledCoupons += 1
                        }
                    }
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }
    func postMemeberIndex(memberID:String) {
        
        let url = "http://3.34.33.15:8080/marketIndex?memberId=\(memberID)&storeId1=0&storeId2=0&storeId3=0&storeId4=0&storeId5=0&storeId6=0&storeId7=0&storeId8=0&storeId9=0&storeId10=0"
        
        // PUT 요청
        AF.request(url, method: .post).response { response in
            print("인덱스post성공")
        }
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

struct CouponBookView_Previews: PreviewProvider {
    static var previews: some View {
        DogamBookView()
    }
}
