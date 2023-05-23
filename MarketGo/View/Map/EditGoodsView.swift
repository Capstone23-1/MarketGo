//import SwiftUI
//import Alamofire
//
//struct EditGoodsView: View {
//    @State private var goods: GoodsOne
//    
//    @State private var imageUploader = ImageUploader()
//
//    @EnvironmentObject var userViewModel: UserModel
//    
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @State private var selectedMarket: MarketOne?
//    @State private var newImage = FileInfo()
//    @State private var imageCate = StoreCategory(categoryID: 5,categoryName: "store")
//    @State private var storeName: String = ""
//    @State private var storeAddress1: String = ""
//    @State var phone = ""
//    @State var storeInfo = ""
//    @State var storeCategory = 0
//    @State var storeNum = ""
//    @State private var cardAvail = false
//    @State private var localAvail = false
//    @State private var selectedImage: UIImage? = nil
//    @State var fileId = 0
//    @State private var isLoading: Bool = false
//    
//    
//    var body: some View {
//        VStack {
//            Form {
//                ImageUploadView(category: $imageCate.categoryName, selectedImage: $selectedImage, newImage: $newImage)
//                TextField("Store Name", text: $storeName)
//                TextField("Store Address 1", text: $storeAddress1)
//                TextField("전화번호 ex: 010-1234-1234", text: $phone)
//                TextField("가게 정보", text: $storeInfo)
//                Picker(selection: $storeCategory, label: Text("가게 분류")) {
//                    ForEach(0..<9) { index in
//                        Text(categories[index].name).tag(index)
//                    }
//                }
//                TextField("가게 번호", text: $storeNum)
//                Section(header: Text("가능 여부")) {
//                    Toggle("카드 이용 가능 여부", isOn: $cardAvail)
//                    Toggle("지역 화폐 가능 여부", isOn: $localAvail)
//                }
//            }
//            .onAppear(perform: loadStoreData)
//            .navigationTitle("Update Store")
//           
//            
//            Button(action: {
//                Task {
//                    await updateStoreData()
//                }
//            }) {
//                Text("Update")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            
//        }
//    }
//    
//    func loadStoreData() {
//        
//        async {
//            do {
//                let fileInfo = try await ImageDownloader().fetchImageFileInfo(url: "http://3.34.33.15:8080/file/\(fileId)")
//                selectedImage = try await ImageDownloader().fetchImage(fileInfo: fileInfo)
//                // 사용하려는 이미지가 여기에 있습니다.
//            } catch {
//                // 오류 처리
//                print("Failed to fetch image: \(error)")
//            }
//        }
//
//    }
//    
//    
//    func updateStoreData() async {
//        do {
//            if let image = self.selectedImage {
//                let result = try await imageUploader.uploadImageToServer(image: image, category: imageCate.categoryName, id: String(imageCate.categoryID))
//                print("이미지업로드성공:\(String(describing: result.uploadFileName!))")
//                
//                if let id = result.fileID {
//                    fileId = id
//                    //                    print("file id get : \(storePost.storeFile) id: \(id)")
//                    
//                }
//            } else {
//                print("이미지를 선택하지 않았습니다.")
//                return
//            }
//        }
//            catch {
//                print("Error uploading image: \(error)")
//                isLoading = false
//            }
//        
//
//        let enStoreName=makeStringKoreanEncoded(obse.storeElement.storeName!)
//        let enAddress=makeStringKoreanEncoded(obse.storeElement.storeAddress1!)
//        let enPhoneNum=makeStringKoreanEncoded(obse.storeElement.storePhonenum!)
//        let enInfo=makeStringKoreanEncoded(obse.storeElement.storeInfo!)
//        let enCard=makeStringKoreanEncoded(obse.storeElement.cardAvail!)
//        let enLocal=makeStringKoreanEncoded(obse.storeElement.localAvail!)
//        let url = "http://3.34.33.15:8080/store/\(String(describing: (obse.storeElement.storeID)!))?storeName=\(enStoreName)&storeAddress1=\(enAddress)&storeAddress2=\(enAddress)&storeRatings=0&storePhonenum=\(enPhoneNum)&storeInfo=\(enInfo)&cardAvail=\(enCard)&localAvail=\(enLocal)&storeNum=\(storeNum)&marketId=\(String(describing: (obse.storeElement.storeMarketID?.marketID)!))&storeFile=\(String(describing: (obse.storeElement.storeFile?.fileID)!))&storeCategory=\(String(describing: (obse.storeElement.storeCategory?.categoryID)!))"
//        let headers: HTTPHeaders = ["Content-Type": "application/json"]
//        
//        
//        AF.request(url, method: .put, headers: headers)
//            .validate(statusCode: 200..<300)
//            .responseDecodable(of: StoreElement.self) {response in
//                switch response.result {
//                    case .success(let updatedStore):
//                        print("Update successful: \(updatedStore)")
//                        DispatchQueue.main.async {
//                            obse.storeElement = updatedStore
//                            userViewModel.currentUser?.storeID=updatedStore
//                            self.presentationMode.wrappedValue.dismiss()
//                        }
//                    case .failure(let error):
//                        print(error)
//                }
//            }
//        
//    }
//
//   
//    
//}
