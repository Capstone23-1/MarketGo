//
//  CouponViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/06/08.
//

import Foundation
import SwiftUI
import Alamofire

struct CouponElement: Codable {
    var couponID: Int?
    var storeID: StoreElement?
    var couponInfo,discount,duration: String?
    
            

    enum CodingKeys: String, CodingKey {
        case couponID = "couponId"
        case storeID = "storeId"
        case couponInfo,discount,duration
    }
}

class CouponViewModel: ObservableObject {
    @Published var coupons: [CouponElement] = []
    @Published var marketId : Int?
    
    func fetchCoupons() {
        var url = ""
        if let marketId = marketId {
            url = "http://3.34.33.15:8080/coupon/marketId/\(marketId)"
        }
        else{
            url = "http://3.34.33.15:8080/coupon/all"
        }
        AF.request(url)
            .validate()
            .responseDecodable(of: [CouponElement].self) { response in
                guard let coupons = response.value else { return }
                self.coupons = coupons
                let newCoupon = CouponElement(couponID: 0,couponInfo: "10000원이상 구매시 사용가능",discount: "10% 할인",duration: "23년 12월 31일")
                self.coupons.append(newCoupon)
            }

    }
}
