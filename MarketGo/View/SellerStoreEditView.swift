import SwiftUI
import Alamofire

struct StoreEditView: View {
    @State private var imageUploader = ImageUploader()
    @ObservedObject var obse: ObservableStoreElement
    @EnvironmentObject var userViewModel: UserModel
    @State private var showSheet = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedMarket: MarketOne?
    @State private var newImage = FileInfo()
    @State private var imageCate = StoreCategory(categoryID: 5,categoryName: "store")
    @State private var storeName: String = ""
    @State private var storeAddress1: String = ""
    @State var phone = ""
    @State var storeInfo = ""
    @State var storeCategory = 0
    @State var storeNum = ""
    @State private var cardAvail = false
    @State private var localAvail = false
    @State private var selectedImage: UIImage? = nil
    @State var fileId = 0
    @State private var isLoading: Bool = false
    
    
    var body: some View {
        VStack {
            Form {
                ProfileImageUploadView(category: $imageCate.categoryName, selectedImage: $selectedImage, newImage: $newImage)
                Section(header: Text("가게명,주소,연락처")) {
                    TextField("상점명", text: $storeName)
                    TextField("상점주소", text: $storeAddress1)
                
                    TextField("전화번호 ex: 010-1234-1234", text: $phone)
                }
                Section(header: Text("가게 정보 설명란")) {
                    TextField("가게 정보", text: $storeInfo)
                }
                    Picker(selection: $storeCategory, label: Text("가게 분류")) {
                        ForEach(0..<9) { index in
                            Text(categories[index].name).tag(index)
                        }
                    }
                
                TextField("가게 번호", text: $storeNum)
                Section(header: Text("가능 여부")) {
                    Toggle("카드 이용 가능 여부", isOn: $cardAvail)
                    Toggle("지역 화폐 가능 여부", isOn: $localAvail)
                }
            }
            .onAppear(perform: loadStoreData)
            .navigationTitle("상점 정보 수정")
           
            
            Button(action: {
                Task {
                    await updateStoreData()
                }
            }) {
                Text("수정")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
        }
    }
    
    func loadStoreData() {
        storeName = obse.storeElement.storeName ?? ""
        storeAddress1 = obse.storeElement.storeAddress1 ?? ""
        phone=obse.storeElement.storePhonenum ?? ""
        storeInfo=obse.storeElement.storeInfo ?? ""
        storeCategory=obse.storeElement.storeCategory!.categoryID ?? 0
        storeNum=String(describing:obse.storeElement.storeNum!)
        fileId=(obse.storeElement.storeFile?.fileID)!
        cardAvail = obse.storeElement.cardAvail == "가능"
        localAvail = obse.storeElement.localAvail == "가능"
        async {
            do {
                let fileInfo = try await ImageDownloader().fetchImageFileInfo(url: "http://3.34.33.15:8080/file/\(fileId)")
                selectedImage = try await ImageDownloader().fetchImage(fileInfo: fileInfo)
                // 사용하려는 이미지가 여기에 있습니다.
            } catch {
                // 오류 처리
                print("Failed to fetch image: \(error)")
            }
        }

    }
    
    
    func updateStoreData() async {
        do {
            if let image = self.selectedImage {
                let result = try await imageUploader.uploadImageToServer(image: image, category: imageCate.categoryName, id: String(imageCate.categoryID))
                print("이미지업로드성공:\(String(describing: result.uploadFileName!))")
                
                if let id = result.fileID {
                    fileId = id
                    //                    print("file id get : \(storePost.storeFile) id: \(id)")
                    
                }
            } else {
                print("이미지를 선택하지 않았습니다.")
                return
            }
        }
            catch {
                print("Error uploading image: \(error)")
                isLoading = false
            }
        
            
        obse.storeElement.storeName = storeName
        obse.storeElement.storeAddress1 = storeAddress1
        obse.storeElement.storeCategory?.categoryID=storeCategory
        obse.storeElement.storeNum=Int(storeNum)
        
        obse.storeElement.cardAvail =  cardAvail ? "가능" : "이용불가"
        obse.storeElement.localAvail =  localAvail ? "가능" : "이용불가"
        obse.storeElement.storeFile?.fileID=fileId
        let enStoreName=makeStringKoreanEncoded(obse.storeElement.storeName!)
        let enAddress=makeStringKoreanEncoded(obse.storeElement.storeAddress1!)
        let enPhoneNum=makeStringKoreanEncoded(obse.storeElement.storePhonenum!)
        let enInfo=makeStringKoreanEncoded(obse.storeElement.storeInfo!)
        let enCard=makeStringKoreanEncoded(obse.storeElement.cardAvail!)
        let enLocal=makeStringKoreanEncoded(obse.storeElement.localAvail!)
        let url = "http://3.34.33.15:8080/store/\(String(describing: (obse.storeElement.storeID)!))?storeName=\(enStoreName)&storeAddress1=\(enAddress)&storeAddress2=\(enAddress)&storeRatings=0&storePhonenum=\(enPhoneNum)&storeInfo=\(enInfo)&cardAvail=\(enCard)&localAvail=\(enLocal)&storeNum=\(storeNum)&marketId=\(String(describing: (obse.storeElement.storeMarketID?.marketID)!))&storeFile=\(String(describing: (obse.storeElement.storeFile?.fileID)!))&storeCategory=\(String(describing: (obse.storeElement.storeCategory?.categoryID)!))"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        
        AF.request(url, method: .put, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: StoreElement.self) {response in
                switch response.result {
                    case .success(let updatedStore):
                        print("Update successful: \(updatedStore)")
                        DispatchQueue.main.async {
                            obse.storeElement = updatedStore
                            userViewModel.currentUser?.storeID=updatedStore
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        
    }

   
    
}

class ObservableStoreElement: ObservableObject {
    @Published var storeElement: StoreElement
    
    init(storeElement: StoreElement) {
        self.storeElement = storeElement
    }
}
