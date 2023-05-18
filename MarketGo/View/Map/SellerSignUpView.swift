//
//  SellerSignUp.swift
//  MarketGo
//
//  Created by ram on 2023/05/10.
//

import SwiftUI
import FirebaseAuth
import Alamofire
struct SellerSignUpView: View {
    @StateObject private var viewModel = SellerSignUpViewModel()
    @EnvironmentObject private var storePost: StorePostViewModel
    @State private var moveToSignInView = false
    @State private var moveToCoiceView = false
    @State private var moveToWriteView = false
    @State private var selectedMarket: MarketOne? // 선택된 마켓 정보를 저장할 상태 변수
    @State private var marketName: String = "" // TextField에 바인딩할 변수
    @State private var newStore: StoreElement?
    @State private var imageCate = StoreCategory(categoryID: 3,categoryName: "test")
    
    var body: some View {
        NavigationView {
            
            Form {
                ImageUploadView(category: $imageCate.categoryName, did: $imageCate.categoryID)

                TextField("가게명", text: $storePost.storeName)
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
                SecureField("비밀번호 확인", text: $viewModel.confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                }
                Button(action: {
                    self.moveToWriteView = true
                }) {
                    Text("가게정보입력")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.accentColor)
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity)
                }
                .sheet(isPresented: $moveToWriteView) {
                    StoreEnrollView()
                }
                
                Button(action: {
                    
                    viewModel.nickName=storePost.storeName
                    storePost.storeAddress2=storePost.storeAddress1
                    storePost.marketId = selectedMarket!.marketID
//                    storePost.storeFile=
                    storePost.enrollStore()
//                    viewModel.signUp { success in
//                        if success {
//                            print("회원가입 성공, uid: \(viewModel.uid ?? "N/A")")
//                            self.moveToSignInView = true
//                        } else {
//                            print("회원가입 실패")
//                        }
//                    }
                }) {
                    Text("회원가입")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(viewModel.isLoading)
                .fullScreenCover(isPresented: $moveToSignInView) {
                    SignInView()
                }
            }.navigationTitle("  상점회원 가입")
        }
        
    }
}
class StorePostViewModel: ObservableObject {
    @Published var newStore: StoreElement? // newStore를 옵셔널 타입으로 선언
    
    var storeName: String = ""
    var storeAddress1: String = ""
    var storeAddress2: String = ""
    var storeRatings: Double = 0.0
    var storePhonenum: String = ""
    var storeInfo: String = ""
    var cardAvail: String = "가능"
    var localAvail: String = "가능"
    var storeNum: Int = 0
    var marketId: Int = 17
    var storeFile: Int = 24
    var storeCategory: Int = 0
    
    func enrollStore() {
        let parameters: [String: Any] = [
            "storeName": storeName,
            "storeAddress1": storeAddress1,
            "storeAddress2": storeAddress2,
            "storeRatings": storeRatings,
            "storePhonenum": storePhonenum,
            "storeInfo": storeInfo,
            "cardAvail": cardAvail,
            "localAvail": localAvail,
            "storeNum": storeNum,
            "marketId": marketId,
            "storeFile": storeFile,
            "storeCategory": storeCategory
        ]
        
        let url = "http://3.34.33.15:8080/store"
        
        AF.request(url, method: .post, parameters: parameters)
                    .validate()
                    .responseDecodable(of: StoreElement.self) { (response) in
                        switch response.result {
                        case .success(let storeElement):
                            DispatchQueue.main.async {
                                self.newStore = storeElement
                                print(self.newStore?.cardAvail! as Any)
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
        
    }
}
