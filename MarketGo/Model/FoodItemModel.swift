//
//  FoodItemModel.swift
//  MarketGo
//
//  Created by 김주현 on 2023/03/29.
//  상품정보와 가게정보

import SwiftUI
import Alamofire
import Foundation
import Combine


struct Store: Codable, Identifiable {
    let id: Int
    let name: String
    let address1: String
    let address2: String
    let ratings: Double
    let phoneNumber: String
    let info: String
    let isCardAvailable: String
    let isLocalAvailable: String
    let number: Int
    let marketId: Int
    let file: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "storeId"
        case name = "storeName"
        case address1 = "storeAddress1"
        case address2 = "storeAddress2"
        case ratings = "storeRatings"
        case phoneNumber = "storePhonenum"
        case info = "storeInfo"
        case isCardAvailable = "cardAvail"
        case isLocalAvailable = "localAvail"
        case number = "storeNum"
        case marketId
        case file = "storeFile"
    }
}

class StoreViewModel: ObservableObject {
    @Published var stores: [Store] = []
    
    func fetchStores(marketId: Int) {
        let url = "http://3.34.33.15:8080/store/all"
        let parameters: [String: Any] = ["marketId": marketId]
        
        AF.request(url, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let stores = try JSONDecoder().decode([Store].self, from: data)
                    DispatchQueue.main.async {
                        self.stores = stores
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


//struct StoreView: View {
//    @ObservedObject var viewModel = StoreViewModel()
//
//    var body: some View {
//        NavigationView {
//            List(viewModel.stores) { store in
//                VStack(alignment: .leading) {
//                    Text(store.name)
//                        .font(.headline)
//                    Text(store.address1)
//                    Text(store.address2)
//                    Text(store.phoneNumber)
//                }
//            }
//            .navigationTitle("Stores")
//        }
//        .onAppear {
//            viewModel.fetchStores()
//        }
//    }
//}
//


//MarketId를 입력받아 특정 시장 내의 모든 goods들을 가져옴
//class GoodsViewModel: ObservableObject {
//    @Published var goods: Goods = []
//
//    func fetchGoods() {
//        let url = "http://3.34.33.15:8080/goods/all"
//
//        AF.request(url).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    let decoder = JSONDecoder()
//                    let goods = try decoder.decode(Goods.self, from: data)
//                    DispatchQueue.main.async {
//                        self.goods = goods
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//}





//struct ContentView: View {
//    @ObservedObject var goodsViewModel = GoodsViewModel()
//    @State private var marketId: Int = 123 // Set your desired marketId
//
//    var body: some View {
//        VStack {
//            Button("Fetch Goods") {
//                goodsViewModel.fetchGoods(marketId: marketId)
//            }
//
//            List(goodsViewModel.goods) { goods in
//                VStack(alignment: .leading) {
//                    Text(goods.goodsName)
//                        .font(.headline)
//                    Text("Price: \(goods.goodsPrice)")
//                        .font(.subheadline)
//                    Text("Unit: \(goods.goodsUnit)")
//                        .font(.subheadline)
//                    Text("Origin: \(goods.goodsOrigin)")
//                        .font(.subheadline)
//                }
//            }
//        }
//    }
//}


struct FileData: Codable {
    let fileId: Int
    let originalFileName: String
    let uploadFileName: String
    let uploadFilePath: String
    let uploadFileUrl: String
}

class FileDataViewModel: ObservableObject {
    @Published var fileData: FileData?
    
    func getFileData(fileId: Int) {
        guard let url = URL(string: "http://3.34.33.15:8080/file/\(fileId)") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data
            else {
                print("Invalid response")
                return
            }
            
            do {
                let fileData = try JSONDecoder().decode(FileData.self, from: data)
                DispatchQueue.main.async {
                    self.fileData = fileData
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}

//struct ContentView: View {
//    @StateObject var viewModel = FileDataViewModel()
//    @State var fileId: Int = 123 // 예시
//
//    var body: some View {
//        VStack {
//            if let fileData = viewModel.fileData {
//                Text("File Id: \(fileData.fileId)")
//                Text("Original File Name: \(fileData.originalFileName)")
//                Text("Upload File Name: \(fileData.uploadFileName)")
//                Text("Upload File Path: \(fileData.uploadFilePath)")
//                Text("Upload File URL: \(fileData.uploadFileUrl)")
//            } else {
//                Text("Loading...")
//            }
//        }
//        .onAppear {
//            viewModel.getFileData(fileId: fileId)
//        }
//    }
//}




//public struct Store: Hashable, Identifiable {
//
//    public let id = UUID()
//
//    let store_name: String //가게이름
//    let address1: String //주소(도로명주소/지번주소)
//    let store_ratings: Double //평점
//    let store_phone_num: String //가게 전화번호
//    let card_avail: Bool //카드결제 가능여부
//    let local_avail: Bool //지역화폐 가능여부
//    let reviewCnt: Int //리뷰개수
//    let products: [FoodItem] //가게에서 파는 물품정보
//    let store_num: Int
//    let store_image: String//가게사진
//}
//
//extension Store{
//
//    static let foods: [FoodItem] = FoodItem.foodItems
//
//    static let stores: [Store] = [
//        Store(store_name: "영찬과일", address1: "123 Main St", store_ratings: 4.5, store_phone_num: "555-555-1234", card_avail: true, local_avail: false, reviewCnt: 10, products: [Self.foods[0], Self.foods[1],Self.foods[2]], store_num: 1, store_image: "영찬과일"),
//        Store(store_name: "Store B", address1: "456 Elm St", store_ratings: 4.0, store_phone_num: "555-555-5678", card_avail: false, local_avail: true, reviewCnt: 20, products: [Self.foods[3],Self.foods[4]], store_num: 2, store_image: "소람과일"),
//        Store(store_name: "Store C", address1: "789 Maple St", store_ratings: 3.5, store_phone_num: "555-555-9012", card_avail: true, local_avail: true, reviewCnt: 5, products: [], store_num: 3, store_image: "소람과일"),
//        Store(store_name: "주현상회", address1: "321 Oak St", store_ratings: 3.0, store_phone_num: "555-555-3456", card_avail: false, local_avail: false, reviewCnt: 15, products: [], store_num: 4, store_image: "소람과일"),
//        Store(store_name: "맹구과일", address1: "654 Cedar St", store_ratings: 2.5, store_phone_num: "555-555-7890", card_avail: true, local_avail: false, reviewCnt: 8, products: [], store_num: 5, store_image: "소람과일")
//    ]
//}



//public struct FoodItem: Hashable, Identifiable {
//
//    public let id = UUID()
//
//    let name: String
//    let storeName: String
//    let imageName: String
//    let price: Int
//    let store_num: Int
//    var quantity: Int = 1
//}
//
//extension FoodItem {
//    static let foodItems: [FoodItem] = [
//        FoodItem(name: "Apple", storeName: "Store A", imageName: "apple", price: 100, store_num: 1),
//        FoodItem(name: "Banana", storeName: "Store A", imageName: "banana", price: 150, store_num: 1),
//        FoodItem(name: "Carrot", storeName: "Store A", imageName: "carrot", price: 200, store_num: 1),
//        FoodItem(name: "Orange", storeName: "Store B", imageName: "orange", price: 120, store_num: 2),
//        FoodItem(name: "Grape", storeName: "Store B", imageName: "grape", price: 300, store_num: 2),
//        FoodItem(name: "Watermelon", storeName: "Store C", imageName: "watermelon", price: 1000, store_num: 3),
//        FoodItem(name: "Pineapple", storeName: "Store C", imageName: "pineapple", price: 800, store_num: 3),
//        FoodItem(name: "Tomato", storeName: "Store D", imageName: "tomato", price: 150, store_num: 4),
//        FoodItem(name: "Broccoli", storeName: "Store E", imageName: "broccoli", price: 250, store_num: 5),
//        FoodItem(name: "Potato", storeName: "Store E", imageName: "potato", price: 200, store_num: 5),
//    ]
//
//}


