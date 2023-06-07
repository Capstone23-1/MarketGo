//
//  PostGoodsVIewModel.swift
//  MarketGo
//
//  Created by ram on 2023/06/06.
//

import Combine
import Alamofire
import UIKit
import SwiftUI
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
    @Published var text = ""
    var successGoods:GoodsOne?
    var imageUploader = ImageUploader()
    
    func postGoodsData(){
        let enPrice = makeStringKoreanEncoded(goodsPrice.replacingOccurrences(of: "원", with: ""))
        let url = "http://3.34.33.15:8080/goodsData?goodsId=\((successGoods?.goodsID)!)&price=\(enPrice)"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        
        AF.request(url, method: .post, headers: headers)
            .response { response in
                
                switch response.result {
                    case .success(let data):
                        
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
    
    func postGoods() async {
        do {
            if let image = self.selectedImage {
                let result = try await imageUploader.uploadImageToServer(image: image, category: imageCate.categoryName, id: String(imageCate.categoryID))

                if let id = result.fileID {
                    fileId = id
                    
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
        let enPrice = makeStringKoreanEncoded(goodsPrice.replacingOccurrences(of: "원", with: ""))
        let url = "http://3.34.33.15:8080/goods?goodsName=\(enGoodsName)&marketId=\(String(describing: marketId))&storeId=\(String(describing: storeId))&goodsFile=\(String(describing: fileId))&goodsPrice=\(enPrice)&goodsUnit=\(enUnit)&goodsInfo=\(enGoodsInfo)&goodsOrigin=\(enOrigin)&isAvail=1"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        
        AF.request(url, method: .post, headers: headers)
            .responseDecodable(of: GoodsOne.self) { response in
                
                switch response.result {
                    case .success(let goods):
                        if response.response?.statusCode == 200 {
                            self.successGoods = goods
                            self.postGoodsData()
                            
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                        // Optionally set the alert item to show an error message
                }
            }
        
        
    }
    func fetchImageData() {
        AF.request("http://3.34.33.15:8080/json/image/\(text)").responseDecodable(of: NerModel.self) { response in
            switch response.result {
                case .success(let nerModel):
//                    print(nerModel)
                    self.goodsName = (nerModel.text1)!
                    self.goodsUnit = (nerModel.text2)!
                    self.goodsPrice = (nerModel.text3)!
                case .failure(let error):
                    print(error)
                    // Handle the error according to your needs
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



