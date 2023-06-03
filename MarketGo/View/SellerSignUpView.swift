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
    @State private var confirmPasswordMatch: Bool = false
    @State private var passwordValid: Bool = false // 패스워드 유효성을 확인하는 변수
    
    var body: some View {
        NavigationView {
            ZStack{
                Form {
                    ImageUploadView(category: $imageCate.categoryName,  selectedImage: $selectedImage, newImage: $newImage)
                    
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
                        .sheet(isPresented: $moveToCoiceView,onDismiss: {
                            print("marketId:\(String(describing: selectedMarket?.marketID))")
                        }) {
                            SellerMarketChoiceView(selectedMarket: $selectedMarket, isPresented: $moveToCoiceView, marketName: $marketName)
                        }
                    }
                    Section(header:Text("추가적인 가게 정보를 입력해주세요")){
                        Button(action: {
                            self.moveToWriteView = true
                        }) {
                            Text("가게정보입력")//입력되지않으면 회원가입이 안되도록
                                .background(Color.white)
                                .foregroundColor(.accentColor)
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity)
                        }
                        .sheet(isPresented: $moveToWriteView, onDismiss: {
                            printStorePost()
                        }) {
                            PostStoreView(storeName: $storeName)
                        }
                    }
                    
                    
                    
                    
                    Section(header:Text("이메일")){
                        TextField("go@market.com", text: $viewModel.email)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                    }
                    Section(header: Text("6글자 이상의 비밀번호를 입력해주세요")) {
                        SecureField("비밀번호", text: $viewModel.password)
                            .autocapitalization(.none)
                            .padding()
                            .disableAutocorrection(true)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .onChange(of: viewModel.password) { newValue in
                                passwordValid = newValue.count >= 6 // 비밀번호가 6자 이상인지 확인
                                confirmPasswordMatch = newValue == viewModel.confirmPassword // 비밀번호와 비밀번호 확인이 같은지 확인
                            }
                            .overlay(
                                HStack {
                                    Spacer()
                                    Image(systemName: passwordValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        .foregroundColor(passwordValid ? .green : .red)
                                }.padding(.horizontal)
                            )
                        
                        SecureField("비밀번호 확인", text: $viewModel.confirmPassword)
                            .padding()
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .onChange(of: viewModel.confirmPassword) { newValue in
                                confirmPasswordMatch = newValue == viewModel.password // 비밀번호와 비밀번호 확인이 같은지 확인
                            }
                            .overlay(
                                HStack {
                                    Spacer()
                                    Image(systemName: confirmPasswordMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        .foregroundColor(confirmPasswordMatch ? .green : .red)
                                }.padding(.horizontal)
                            )
                    }
                    if let error = viewModel.error {
                        Text(error)
                            .foregroundColor(.red)
                    }
                    
                    Button {
                        Task {
                            await processSignUp()
                        }
                    } label: {
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
                    
                    
                }
                
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
                storePost.storeAddress1 = ""
                storePost.storeAddress2 = ""
                storePost.cardAvail = "가능"
                storePost.localAvail = "가능"
                storePost.storeInfo = ""
                storePost.storePhonenum = ""
                storePost.storeCategory = 0
            }
        }
        
        
    }
    
    func processSignUp() async {
        isLoading1 = true
        do {
            if let image = self.selectedImage {
                let result = try await imageUploader.uploadImageToServer(image: image, category: imageCate.categoryName, id: String(imageCate.categoryID))
                print("이미지업로드성공:\(String(describing: result.uploadFileName!))")
                isLoading2 = true
                if let id = result.fileID {
                    storePost.storeFile = id
                    print("file id get : \(storePost.storeFile) id: \(id)")
                    storePost.marketId=selectedMarket!.marketID
                }
            } else {
                print("이미지를 선택하지 않았습니다.")
                return
            }
            
            let enroll = try await storePost.enrollStore { result in
                switch result {
                    case .success(let storeElement):
                        viewModel.storeId = storeElement.storeID!
                        viewModel.storeMarketId=selectedMarket!.marketID
                        print("vm.marketId: \(viewModel.storeMarketId)")
                        viewModel.nickName=storeElement.storeName!
                        
                        print("-------")
                        print(viewModel.storeId)
                    case .failure(let error):
                        // 에러가 발생했을 때의 동작
                        print("Error enrolling store: \(error)")
                }
            }
            
            DispatchQueue.main.async {
                viewModel.signUp { (success, error) in
                    if success {
                        print("회원가입 성공, uid: \(viewModel.uid ?? "N/A")")
                        self.moveToSignInView = true
                    } else {
                        print("회원가입 실패: \(error?.localizedDescription ?? "")")
                    }
                    isLoading1 = false
                    isLoading2 = false
                }
            }
        } catch {
            print("Error uploading image: \(error)")
            isLoading1 = false
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
