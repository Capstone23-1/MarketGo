//
//  CouponRowView.swift
//  MarketGo
//
//  Created by ram on 2023/06/08.
//
import SwiftUI
import Foundation
struct CouponRow: View {
    var coupon: CouponElement
    @EnvironmentObject var userModel:UserModel
    
    
    var body: some View {
        NavigationLink(destination: CouponUseView(coupon: coupon)) {
            
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                        
                        VStack(alignment: .center, spacing: 8) {
                            if ten == 1,coupon.couponID == 0{
                                Text("도감 채우기 보상")
                                    .font(.title2)
                                    
                            }
                            else{
                                Text("\((coupon.storeID?.storeName) ?? "" )")
                                    .font(.title2)
                            }
                            
                            
                            if let discount = coupon.discount {
                                Text(discount)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                            else{
                                Text("")
                                    .font(.title)
                            }
                            
                                
                            Text(" ~ \((coupon.duration) ?? "")")
                                .font(.footnote)
                                .foregroundColor(.gray)
                       
                        }
                        .padding()
                    
                
            }

            .padding()
        }
    }
}
