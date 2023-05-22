import SwiftUI
import FirebaseAuth
import Alamofire
struct SellerEditInfoView: View {
    @EnvironmentObject var sellervm: UserModel
    @State private var selectedImage: UIImage? = nil // 선택된 이미지를 저장할 변수
    @State private var isLoading: Bool = false
    @State private var move = false
    @State private var selectedMarket: MarketOne? // 선택된 마켓 정보를 저장할 상태 변수
    @State private var marketName: String = "" // TextField에 바인딩할 변수
    @State private var newStore: StoreElement?
    @State private var imageCate = StoreCategory(categoryID: 3,categoryName: "store")
    @State private var newImage = FileInfo()
    @State private var imageUploader = ImageUploader()
    
    @State private var cardAvail = false
    @State private var localAvail = false
    @State private var storeCategory = 0
    
    @State var storeName = ""
    @State var address=""
    @State var phone=""
    @State var storeInfo=""
    
    
    
    var body: some View {
        NavigationView {
            ZStack{
                Form {
                    //                    ImageUploadView(category: $imageCate.categoryName, did: $imageCate.categoryID, selectedImage: $selectedImage, newImage: $newImage)
                    Section(header: Text("가게 정보")) {
                        TextField("가게 이름", text: $storeName)
                            .autocapitalization(.none)
                            .onAppear {
                                // 초기값 설정
                                self.storeName = sellervm.currentUser?.memberName ?? ""
                            }
                            .onChange(of: storeName) { newValue in
                                // 값이 변경될 때 사용자 모델 업데이트
                                sellervm.currentUser?.memberName = newValue
                            }
                        
                        
                        TextField("시장 내 상세주소", text: $address)
                            .autocapitalization(.none)
                            .onAppear {
                                // 초기값 설정
                                self.address = sellervm.currentUser?.storeID?.storeAddress1 ?? ""
                            }
                            .onChange(of: address) { newValue in
                                // 값이 변경될 때 사용자 모델 업데이트
                                sellervm.currentUser?.storeID?.storeAddress1 = address
                                sellervm.currentUser?.storeID?.storeAddress2 = address
                            }
                        
                        TextField("전화번호 ex: 010-1234-1234", text: $phone)
                            .autocapitalization(.none)
                            .onAppear {
                                // 초기값 설정
                                self.phone = sellervm.currentUser?.storeID?.storePhonenum ?? ""
                            }
                            .onChange(of: address) { newValue in
                                // 값이 변경될 때 사용자 모델 업데이트
                                sellervm.currentUser?.storeID?.storePhonenum = phone
                            }
                        TextField("가게 정보", text: $storeInfo)
                            .autocapitalization(.none)
                            .onAppear {
                                // 초기값 설정
                                self.storeInfo = sellervm.currentUser?.storeID?.storeInfo ?? ""
                            }
                            .onChange(of: address) { newValue in
                                // 값이 변경될 때 사용자 모델 업데이트
                                sellervm.currentUser?.storeID?.storeInfo = storeInfo
                            }
                        
                    }
                    
                }
            }
        }
        
    }
    
}
