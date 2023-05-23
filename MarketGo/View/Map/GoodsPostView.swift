import SwiftUI
import Alamofire
import UIKit

struct GoodsPostView: View {
    @State private var imageUploader = ImageUploader()
    @EnvironmentObject var userViewModel: UserModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var selectedMarket: MarketOne?
    @State var newImage = FileInfo()
    @State var imageCate = StoreCategory(categoryID: 0,categoryName: "goods")
    @State var selectedImage: UIImage? = nil
    @State var isLoading = false
    @State var goodsName = ""
    @State var goodsUnit = ""
    @State var goodsInfo = ""
    @State var goodsOrigin = ""
    @State var fileId = 0
    @State var goodsPrice = ""
    @State var storeId = 0
    @State var marketId = 0
    

    var body: some View {
        VStack {
            Form {
                ImageUploadView(category: $imageCate.categoryName, selectedImage: $selectedImage, newImage: $newImage)
                TextField("상품명", text: $goodsName)
                TextField("가격", text: $goodsPrice)
                TextField("단위", text: $goodsUnit)
                TextField("원산지", text: $goodsOrigin)
                TextField("물품 설명", text: $goodsInfo)
            }
        }
        .navigationTitle("물품 등록")
        .onAppear(perform: loadView)
        
        Button(action: {
            Task {
                await postGoods()
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
        storeId = (userViewModel.currentUser?.storeID?.storeID)!
        marketId = (userViewModel.currentUser?.storeID?.storeMarketID!.marketID)!
        
    }
    
    
    func postGoods() async {
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
        
        let enGoodsName = makeStringKoreanEncoded(goodsName)
        let enUnit = makeStringKoreanEncoded(goodsUnit)
        let enGoodsInfo = makeStringKoreanEncoded(goodsInfo)
        let enOrigin = makeStringKoreanEncoded(goodsOrigin)
        
        let url = "http://3.34.33.15:8080/goods?goodsName=\(enGoodsName)&marketId=\(String(describing: marketId))&storeId=\(String(describing: storeId))&goodsFile=\(String(describing: fileId))&goodsPrice=\(goodsPrice)&goodsUnit=\(enUnit)&goodsInfo=\(enGoodsInfo)&goodsOrigin=\(enOrigin)&isAvail=1"
            let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        
        AF.request(url, method: .post, headers: headers)
            .responseJSON{ response in
                    debugPrint(response)
                }
        
    }
    
    
    
    
    
}
