import SwiftUI
import Alamofire

class EditGoodsViewModel: ObservableObject {
    @Published var imageUploader = ImageUploader()
    @Published var goods: GoodsOne
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
    @Published var isAvail = 1

    init(goods: GoodsOne) {
        self.goods = goods
        loadViewModel()
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
        let realAvail = String(describing: goods.isAvail!)
        let url = "http://3.34.33.15:8080/goods/\(String(describing: goods.goodsID!))?goodsName=\(enGoodsName)&marketId=\(String(describing: (goods.goodsMarket?.marketID)!))&storeId=\(String(describing: (goods.goodsStore?.storeID)!))&goodsFile=\(String(describing: (goods.goodsFile?.fileID)!))&goodsPrice=\(goodsPrice)&goodsUnit=\(enUnit)&goodsInfo=\(enGoodsInfo)&goodsOrigin=\(enOrigin)&isAvail=\(String(describing: goods.isAvail!))"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        
        AF.request(url, method: .put, headers: headers)
            .responseJSON{ response in
                debugPrint(response)
            }

        
    }
}
