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
    @ObservedObject var goodsViewModel = GoodsViewModel2()
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                
                GoodsImage(url: URL(string: store.storeFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo"))
                
                }
            
            VStack(alignment: .leading){
                
                Text(store.storeName ?? "")
                    .font(.headline)
                    .foregroundColor(.black)

                Text("가게 주소: \(store.storeAddress1 ?? "") \(store.storeAddress2 ?? "")")
                    .foregroundColor(.black)

                Text("가게 유형: \(store.storeCategory?.categoryName ?? "")")
                    .foregroundColor(.black)
                
                Text("전화번호 : \(store.storePhonenum ?? "")")
                    .foregroundColor(.black)

                Text("가게 소개 : \(store.storeInfo ?? "")")
                    .foregroundColor(.black)

                Text("카드 사용 가능 여부 : \(store.cardAvail ?? "")")
                    .foregroundColor(.black)

                Text("지역 화폐 사용 가능 여부 : \(store.localAvail ?? "")")
                    .foregroundColor(.black)

                
            }
                                
                                                
//                if let market = store.storeMarketID {
//                    Text("Market: \(market.marketName ?? "")")
//                        .foregroundColor(.black)
//
//                    Text("Market Address: \(market.marketAddress1 ?? "") \(market.marketAddress2 ?? "")")
//                        .foregroundColor(.black)
//
//                    Text("Market Location: \(market.marketLocation ?? "")")
//                        .foregroundColor(.black)
//
//                    Text("Parking: \(market.parking ?? "")")
//                        .foregroundColor(.black)
//
//                    Text("Toilet: \(market.toilet ?? "")")
//                        .foregroundColor(.black)
//
//                    Text("Market Phone: \(market.marketPhonenum ?? "")")
//                        .foregroundColor(.black)
//
//                    Text("Market Giftcard: \(market.marketGiftcard ?? "")")
//                        .foregroundColor(.black)
//
//
//                }
//
//                if let reviewCount = store.reviewCount {
//                    Text("Review Count: \(reviewCount)")
//                        .foregroundColor(.black)
//                }
//
                Divider()
            VStack{
                
                Text("Menu")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top)
            Text("\(store.storeID ?? 0)")
            TestView(storeID: store.storeID ?? 0)
                    .id(UUID())
                
            }
                
//                VStack {
//                        // Menu Board
//                        if !goodsViewModel.goods.isEmpty {
//                            List(goodsViewModel.goods) { good in
//                                VStack(alignment: .leading) {
//                                    Text(good.goodsName ?? "")
//                                        .font(.headline)
//                                    Text(good.goodsInfo ?? "")
//                                        .font(.subheadline)
//                                }
//                            }
//                        } else {
//                            Text("No menu items available")
//                                .foregroundColor(.gray)
//                        }
//                    }
//                    .onAppear {
//                        goodsViewModel.fetchGoods(forGoodsStoreID: store.storeID ?? 0)
//                    }
            }
        }
    }

               
