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
        VStack(alignment: .leading) {
            ScrollView{
                VStack(alignment: .leading) {
                    
                    GoodsImage(url: URL(string: store.storeFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo"))
                    
                    }
            
                VStack(){
                    
                    HStack {
                        
                        Text("작성된 리뷰 \(store.reviewCount ?? 0) 개>")
                        
                        NavigationLink(destination: MenuView(storeID: store.storeID ?? 0)) {
                            Text("메뉴판")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(5)
                        }
                    }
                    Divider()
                    
                    Text(store.storeName ?? "")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("가게 주소: \(store.storeAddress1 ?? "")")
                        .foregroundColor(.black)
                    Divider()

                    Text("가게 유형: \(store.storeCategory?.categoryName ?? "")")
                        .foregroundColor(.black)
                    
                    
                    Text("전화번호 : \(store.storePhonenum ?? "")")
                        .foregroundColor(.black)

                    Text("가게 소개 : \(store.storeInfo ?? "")")
                        .foregroundColor(.black)
                    
                    Divider()
                    
                    VStack{
                        Text("카드 사용 가능 여부 : \(store.cardAvail ?? "")")
                            .foregroundColor(.black)

                        Text("지역 화폐 사용 가능 여부 : \(store.localAvail ?? "")")
                            .foregroundColor(.black)

                    }

                   
                    
                }
                                
                                                    
                    if let market = store.storeMarketID {
                        Text("Market: \(market.marketName ?? "")")
                            .foregroundColor(.black)

                        Text("Market Address: \(market.marketAddress1 ?? "") \(market.marketAddress2 ?? "")")
                            .foregroundColor(.black)

                        Text("Market Location: \(market.marketLocation ?? "")")
                            .foregroundColor(.black)
                        Divider()

                        Text("Parking: \(market.parking ?? "")")
                            .foregroundColor(.black)

                        Text("Toilet: \(market.toilet ?? "")")
                            .foregroundColor(.black)
                        Divider()

                        Text("Market Phone: \(market.marketPhonenum ?? "")")
                            .foregroundColor(.black)

                        Text("Market Giftcard: \(market.marketGiftcard ?? "")")
                            .foregroundColor(.black)


                    }

                   
                    
                
            }
            
            }
        }
}
    

               
