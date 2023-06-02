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
   
    
    func updateGoods(isAvail: Binding<Int>) async {
        let enGoodsName = makeStringKoreanEncoded(goodsName)
        let enUnit = makeStringKoreanEncoded(goodsUnit)
        let enGoodsInfo = makeStringKoreanEncoded(goodsInfo)
        let enOrigin = makeStringKoreanEncoded(goodsOrigin)
        let realAvail = String(describing: goods.isAvail!)
        let url = "http://3.34.33.15:8080/goods/\(String(describing: goods.goodsID!))?goodsName=\(enGoodsName)&marketId=\(String(describing: (goods.goodsMarket?.marketID)!))&storeId=\(String(describing: (goods.goodsStore?.storeID)!))&goodsFile=\(String(describing: (goods.goodsFile?.fileID)!))&goodsPrice=\(goodsPrice)&goodsUnit=\(enUnit)&goodsInfo=\(enGoodsInfo)&goodsOrigin=\(enOrigin)&isAvail=\(String(describing: goods.isAvail!))"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]

        AF.request(url, method: .put, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("굿즈 put 메서드 성공")
                case .failure(let error):
                    print("굿즈 put 메서드 실패: \(error)")
                }
            }
    }

}
import SwiftUI
import Alamofire

class OffAvailGoodsViewModel: ObservableObject {
    @Published var isAvail = 0
    @Published var goods: GoodsOne

    init(goods: GoodsOne) {
        self.goods = goods
        
    }
    
    
    func updateGoods(isAvail: Binding<Int>) async {

        let enGoodsName = makeStringKoreanEncoded(goods.goodsName!)
        let enUnit = makeStringKoreanEncoded(goods.goodsUnit!)
        let enGoodsInfo = makeStringKoreanEncoded(goods.goodsInfo!)
        let enOrigin = makeStringKoreanEncoded(goods.goodsOrigin!)
        let realAvail = String(describing: self.isAvail)
        let url = "http://3.34.33.15:8080/goods/\(String(describing: goods.goodsID!))?goodsName=\(enGoodsName)&marketId=\(String(describing: (goods.goodsMarket?.marketID)!))&storeId=\(String(describing: (goods.goodsStore?.storeID)!))&goodsFile=\(String(describing: (goods.goodsFile?.fileID)!))&goodsPrice=\(goods.goodsPrice!)&goodsUnit=\(enUnit)&goodsInfo=\(enGoodsInfo)&goodsOrigin=\(enOrigin)&isAvail=\(String(describing: realAvail))"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]

        AF.request(url, method: .put, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("굿즈 put 메서드 성공")
                case .failure(let error):
                    print("굿즈 put 메서드 실패: \(error)")
                }
            }
    }

}
