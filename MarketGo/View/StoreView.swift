////
////  StoreView.swift
////  MarketGo
////
////  Created by 김주현 on 2023/04/06.
////
//

//  StoreView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/06.
//

import SwiftUI

struct StoreView: View {
    let store: StoreElement
    @ObservedObject private var goodsViewModel = GoodsViewModel()
    
    var body: some View {
        ScrollView {
            
            VStack {
                
                GoodsImage(url: URL(string: store.storeFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo"))
                
                }
                                Text(store.storeName ?? "")
                                    .font(.headline)
                                    .foregroundColor(.black)
                
                                Text("Address: \(store.storeAddress1 ?? "") \(store.storeAddress2 ?? "")")
                                    .foregroundColor(.black)
                
                                Text("Category: \(store.storeCategory?.categoryName ?? "")")
                                    .foregroundColor(.black)
                
                                Text("Phone: \(store.storePhonenum ?? "")")
                                    .foregroundColor(.black)
                
                                Text("Info: \(store.storeInfo ?? "")")
                                    .foregroundColor(.black)
                
                //                Text("Card Availability: \(store.cardAvail ?? "")")
                //                    .foregroundColor(.black)
                //
//                                Text("Local Availability: \(store.localAvail ?? "")")
//                                    .foregroundColor(.black)
                
                if let market = store.storeMarketID {
                    Text("Market: \(market.marketName ?? "")")
                        .foregroundColor(.black)
                    
                    Text("Market Address: \(market.marketAddress1 ?? "") \(market.marketAddress2 ?? "")")
                        .foregroundColor(.black)
                    
                    Text("Market Location: \(market.marketLocation ?? "")")
                        .foregroundColor(.black)
                    
                    Text("Market Ratings: \(market.marketRatings ?? 0.0)")
                        .foregroundColor(.black)
                    
                    Text("Market Info: \(market.marketInfo ?? "")")
                        .foregroundColor(.black)
                    
                    Text("Parking: \(market.parking ?? "")")
                        .foregroundColor(.black)
                    
                    Text("Toilet: \(market.toilet ?? "")")
                        .foregroundColor(.black)
                    
                    Text("Market Phone: \(market.marketPhonenum ?? "")")
                        .foregroundColor(.black)
                    
                    Text("Market Giftcard: \(market.marketGiftcard ?? "")")
                        .foregroundColor(.black)
                    
                    Text("Market Type: \(market.marketType ?? "")")
                        .foregroundColor(.black)
                    
                    //                    Text("Update Time: \(market.updateTime ?? "")")
                    //                        .foregroundColor(.black)
                }
                
                if let reviewCount = store.reviewCount {
                    Text("Review Count: \(reviewCount)")
                        .foregroundColor(.black)
                }
                
                Divider()
                
                Text("Menu")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top)
                
            }
        }
    }

               
