import SwiftUI
import FirebaseAuth
import Alamofire
struct SellerSignUpView: View {
    @State private var selectedImage: UIImage? = nil // 선택된 이미지를 저장할 변수
    @State private var isLoading1: Bool = false
    @State private var isLoading2: Bool = false
    @StateObject private var viewModel = SellerSignUpViewModel()
    @EnvironmentObject private var storePost: StorePostViewModel
    @State private var moveToSignInView = false
    @State private var moveToCoiceView = false
    @State private var moveToWriteView = false
    @State private var selectedMarket: MarketOne? // 선택된 마켓 정보를 저장할 상태 변수
    @State private var marketName: String = "" // TextField에 바인딩할 변수
    @State private var newStore: StoreElement?
    @State private var imageCate = StoreCategory(categoryID: 3,categoryName: "store")
    @State private var newImage = FileInfo()
    @State private var imageUploader = ImageUploader()
    @State var storeName = ""
    @State private var passwordsMatch: Bool = false
    var body: some View {
        NavigationView {
            ZStack{
                Form {
                    ImageUploadView(category: $imageCate.categoryName, did: $imageCate.categoryID, selectedImage: $selectedImage, newImage: $newImage)
                    
                    TextField("가게명", text: $storeName)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    
                    HStack{
                        TextField("소속시장", text: $marketName)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        Button(action: {
                            self.moveToCoiceView = true
                        }) {
                            Text("찾기")
                                .frame(maxWidth: 50)
                                .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .sheet(isPresented: $moveToCoiceView) {
                            SellerMarketChoiceView(selectedMarket: $selectedMarket, isPresented: $moveToCoiceView, marketName: $marketName)
                        }
                    }
                    
                    
                    
                    
                    
                    TextField("이메일", text: $viewModel.email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    SecureField("비밀번호", text: $viewModel.password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
              
                    
                    HStack {
                        SecureField("비밀번호 확인", text: $viewModel.confirmPassword)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        if isPasswordValid() {
                            
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                        }
                        
                    }
                    
                    if let error = viewModel.error {
                        Text(error)
                            .foregroundColor(.red)
                    }
                    Button(action: {
                        self.moveToWriteView = true
                    }) {
                        Text("가게정보입력")//입력되지않으면 회원가입이 안되도록
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.accentColor)
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity)
                    }
                    .sheet(isPresented: $moveToWriteView, onDismiss: {
                        printStorePost()
                    }) {
                        StoreEnrollView(storeName: $storeName)
                    }
                    Button(action: processSignUp) {
                        Text("회원가입")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(isLoading1)
                    .fullScreenCover(isPresented: $moveToSignInView) {
                        SignInView()
                    }
                    
                }.navigationTitle("  상점회원 가입")
                if isLoading2 {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .frame(width: 100, height: 100)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .shadow(radius: 10)
                }
            }
            .onAppear {
                isLoading2 = false
            }
        }
        
        
    }
    func processSignUp() {
        isLoading1=true
        Task {
            do {
                if let image = self.selectedImage {
                    imageUploader.uploadImageToServer(image: image, category: imageCate.categoryName, id: String(imageCate.categoryID)) { result in
                        switch result {
                            case .success(let fileInfo):
                                newImage=fileInfo
                            case .failure(let error):
                                print(error)
                        }
                        print("이미지업로드성공:\(String(describing: newImage.uploadFileName!))")
                        isLoading2 = true
                    }
                    if let id = newImage.fileID {
                        storePost.storeFile = id
                        print("file id get : \(storePost.storeFile) id: \(id)")
                    }
                    
                    viewModel.nickName = storePost.storeName
                    storePost.storeAddress2 = storePost.storeAddress1
                    storePost.marketId = selectedMarket!.marketID
                    DispatchQueue.main.async {
                        storePost.enrollStore()
                    }
                    if let storeID = storePost.newStore?.storeID, let marketID = selectedMarket?.marketID {
                        viewModel.storeId = storeID
                        viewModel.storeMarketId = marketID
                        storePost.newStore?.storeName=storeName
                    }
                    DispatchQueue.main.async {
                        
                        viewModel.signUp { success in
                            if success {
                                print("회원가입 성공, uid: \(viewModel.uid ?? "N/A")")
                                self.moveToSignInView = true
                            } else {
                                print("회원가입 실패")
                            }
                        }
                    }
                }
            } catch {
                print("Error uploading image: \(error)")
            }
        }
    }
    func printStorePost() {
        print("storeName: \(storePost.storeName)")
        print("storeAddress1: \(storePost.storeAddress1)")
        print("storeCategory: \(storePost.storeCategory)")
        print("storePhonenum: \(storePost.storePhonenum)")
        print("storeInfo: \(storePost.storeInfo)")
        print("cardAvail: \(storePost.cardAvail)")
        print("localAvail: \(storePost.localAvail)")
    }
    func isPasswordValid() -> Bool {
        return viewModel.password.count >= 6 && viewModel.password == viewModel.confirmPassword
    }
    
}
