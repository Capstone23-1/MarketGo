import SwiftUI
import Alamofire

struct EditGoodsView: View {
    @State var goods: GoodsOne
    
    @State private var imageUploader = ImageUploader()

    @EnvironmentObject var userViewModel: UserModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
    @State var isAvail = 1 // 추가: 게시여부 토글 상태
    
    
    var body: some View {
        VStack {
            Form {
                ImageUploadView(category: $imageCate.categoryName, selectedImage: $selectedImage, newImage: $newImage)
                TextField("상품명", text: $goodsName)
                TextField("가격", text: $goodsPrice)
                TextField("단위", text: $goodsUnit)
                TextField("원산지", text: $goodsOrigin)
                TextField("물품 설명", text: $goodsInfo)
                Toggle(isOn: Binding(get: {
                    self.isAvail != 0
                }, set: { newValue in
                    self.isAvail = newValue ? 1 : 0
                })) {
                    Text("게시여부")
                }

            }
        }
        .navigationTitle("물품 수정")
        .onAppear(perform: loadViewModel)
        Button(action: {
            Task {
                await updateGoods(isAvail: $isAvail)
            }
        }) {
            Text("Update")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        
    }
    
    func loadViewModel() {
        goodsName = goods.goodsName!
        goodsPrice = String(describing: goods.goodsPrice!)
        goodsUnit = goods.goodsUnit!
        goodsOrigin = goods.goodsOrigin!
        goodsInfo = goods.goodsInfo!
        isAvail = goods.isAvail!
        fileId = (goods.goodsFile?.fileID)!

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
    
    
    func updateGoods(isAvail:Binding<Int>) async {
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
        
            
        goods.goodsName=goodsName
        
        let enGoodsName = makeStringKoreanEncoded(goodsName)
        let enUnit = makeStringKoreanEncoded(goodsUnit)
        let enGoodsInfo = makeStringKoreanEncoded(goodsInfo)
        let enOrigin = makeStringKoreanEncoded(goodsOrigin)
        
        let url = "http://3.34.33.15:8080/goods?goodsName=\(enGoodsName)&marketId=\(String(describing: goods.goodsMarket?.marketID))&storeId=\(String(describing: goods.goodsStore?.storeID!))&goodsFile=\(String(describing: goods.goodsFile?.fileID))&goodsPrice=\(goodsPrice)&goodsUnit=\(enUnit)&goodsInfo=\(enGoodsInfo)&goodsOrigin=\(enOrigin)&isAvail=\(isAvail)"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        
        AF.request(url, method: .post, headers: headers)
            .responseJSON{ response in
                debugPrint(response)
            }

        
    }

   
    
}
