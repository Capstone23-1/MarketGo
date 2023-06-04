import SwiftUI
import Alamofire
import UIKit


struct PostGoodsView: View {
    @StateObject private var viewModel = PostGoodsViewModel()
    
    @EnvironmentObject var userViewModel: UserModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        VStack {
            Form {
                ImageUploadView(category: $viewModel.imageCate.categoryName, selectedImage: $viewModel.selectedImage, newImage: $viewModel.newImage)
                TextField("상품명", text: $viewModel.goodsName)
                TextField("가격", text: $viewModel.goodsPrice)
                TextField("단위", text: $viewModel.goodsUnit)
                TextField("원산지", text: $viewModel.goodsOrigin)
                TextField("물품 설명", text: $viewModel.goodsInfo)
                
            }
        }
        .navigationTitle("물품 등록")
        .onAppear(perform: loadView)
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: alertItem.dismissButton
            )
        }
        .onChange(of: viewModel.alertDismissed) { dismissed in
            if dismissed {
                presentationMode.wrappedValue.dismiss()
            }
        }
        
        Button(action: {
            Task {
                await viewModel.postGoods()
            }
        }) {
            Text("Update")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    func loadView() {
        viewModel.storeId = (userViewModel.currentUser?.storeID?.storeID)!
        viewModel.marketId = (userViewModel.currentUser?.storeID?.storeMarketID!.marketID)!
        
    }
}
import Combine

class PostGoodsViewModel: ObservableObject {
    @Published var newImage = FileInfo()
    @Published var imageCate = StoreCategory(categoryID: 0,categoryName: "goods")
    @Published var selectedImage: UIImage? = nil
    @Published var isLoading = false
    @Published var goodsName = ""
    @Published var goodsUnit = ""
    @Published var goodsInfo = ""
    @Published var goodsOrigin = ""
    @Published var fileId = 0
    @Published var goodsPrice = ""
    @Published var storeId = 0
    @Published var marketId = 0
    @Published var isAvail = 1 // 추가: 게시여부 토글 상태
    @Published var alertItem: AlertItem?
    @Published var alertDismissed = false
    var imageUploader = ImageUploader()
    
    
    
    
    func postGoods() async {
        do {
            if let image = self.selectedImage {
                let result = try await imageUploader.uploadImageToServer(image: image, category: imageCate.categoryName, id: String(imageCate.categoryID))
                print("이미지업로드성공:\(String(describing: result.uploadFileName!))")
                
                if let id = result.fileID {
                    self.fileId = id
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
        
        let enGoodsName = makeStringKoreanEncoded(goodsName)
        let enUnit = makeStringKoreanEncoded(goodsUnit)
        let enGoodsInfo = makeStringKoreanEncoded(goodsInfo)
        let enOrigin = makeStringKoreanEncoded(goodsOrigin)
        let enPrice = makeStringKoreanEncoded(goodsPrice)
        let url = "http://3.34.33.15:8080/goods?goodsName=\(enGoodsName)&marketId=\(String(describing: marketId))&storeId=\(String(describing: storeId))&goodsFile=\(String(describing: fileId))&goodsPrice=\(enPrice)&goodsUnit=\(enUnit)&goodsInfo=\(enGoodsInfo)&goodsOrigin=\(enOrigin)&isAvail=1"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        
        AF.request(url, method: .post, headers: headers)
            .response { response in
                debugPrint(response)
                switch response.result {
                    case .success(let data):
                        // Check response or status code to ensure the request was successful
                        // Here I'm just assuming a status code of 200 means success
                        if response.response?.statusCode == 200 {
                            self.alertItem = AlertItem(
                                title: Text("성공"),
                                message: Text("상품등록에 성공하였습니다"),
                                dismissButton: .default(Text("OK")) {
                                    self.alertDismissed = true
                                }
                            )
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                        // Optionally set the alert item to show an error message
                }
            }
        
        
    }
}
struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}
