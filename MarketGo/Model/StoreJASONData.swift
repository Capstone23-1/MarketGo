//
//  StoreJASONData.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/12.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let store = try? JSONDecoder().decode(Store.self, from: jsonData)

import Foundation
import SwiftUI
import Alamofire

// MARK: - StoreElement
struct StoreElement: Codable, Identifiable {
    var storeID: Int?
    var storeName, storeAddress1, storeAddress2: String?
    var storeCategory: StoreCategory?
    var storeRatings: Double?
    var storePhonenum, storeInfo, cardAvail, localAvail: String?
    var storeNum: Int?
    var storeMarketID: StoreMarketID?
    var storeFile: StoreFile?
    var reviewCount: Int?

    enum CodingKeys: String, CodingKey {
        case storeID = "storeId"
        case storeName, storeAddress1, storeAddress2, storeCategory, storeRatings, storePhonenum, storeInfo, cardAvail, localAvail, storeNum
        case storeMarketID = "storeMarketId"
        case storeFile, reviewCount
    }
    
    var id: Int? {
           return storeID
       }
}


// MARK: - StoreFile
//struct StoreFile: Codable {
//    var fileID: Int?
//    var originalFileName, uploadFileName, uploadFilePath: String?
//    var uploadFileURL: String?
//
//    enum CodingKeys: String, CodingKey {
//        case fileID = "fileId"
//        case originalFileName, uploadFileName, uploadFilePath
//        case uploadFileURL = "uploadFileUrl"
//    }
//}

// MARK: - StoreMarketID
struct StoreMarketID: Codable {
    var marketID: Int?
    var marketName, marketAddress1, marketAddress2, marketLocation: String?
    var marketLatitude, marketLongitude, marketRatings: Double?
    var marketInfo, parking, toilet, marketPhonenum: String?
    var marketGiftcard, marketType, updateTime: String?
    var marketFile, marketMap: StoreFile?
    var reviewCount: Int?

    enum CodingKeys: String, CodingKey {
        case marketID = "marketId"
        case marketName, marketAddress1, marketAddress2, marketLocation, marketLatitude, marketLongitude, marketRatings, marketInfo, parking, toilet, marketPhonenum, marketGiftcard, marketType, updateTime, marketFile, marketMap, reviewCount
    }
}

typealias Store = [StoreElement]

class StoreViewModel: ObservableObject {
    @Published var stores: Store = []

    func fetchStores(marketId: Int) {
        let url = "http://3.34.33.15:8080/store/all"
        let parameters: [String: Any] = [
            "marketId": marketId
        ]

        AF.request(url, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let stores = try decoder.decode(Store.self, from: data)
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
