
//  StoreView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/06.
//

import SwiftUI

struct StoreView: View {
    let store: StoreElement
    @ObservedObject var goodsViewModel = GoodsViewModel2()
    @State private var isWritingReview = false
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView{
                VStack(alignment: .leading) {
                    
                    GoodsImage(url: URL(string: store.storeFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo"))
                    
                }
                
                VStack(){
                    
                    HStack {
                        
                        NavigationLink(destination: StoreReviewListView(store: store)){
                            Text("작성된 리뷰 \(store.reviewCount ?? 0) 개>")
                        }
                        
                        NavigationLink(destination: MenuView(storeID: store.storeID ?? 0, storeName: store.storeName ?? "")) {
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
                Divider()
                
                
                if let market = store.storeMarketID {
                    Text("\(market.marketName ?? "")")
                        .foregroundColor(.black)
                    
                    Text("시장 주소 : \(market.marketAddress1 ?? "") \(market.marketAddress2 ?? "")")
                        .foregroundColor(.black)
                    
                    Text("시장 위치: \(market.marketLocation ?? "")")
                        .foregroundColor(.black)
                    Divider()
                    
                    Text("주차 가능 여부 : \(market.parking ?? "")")
                        .foregroundColor(.black)
                    
                    Text("화장실 유무: \(market.toilet ?? "")")
                        .foregroundColor(.black)
                    Divider()
                    
                    Text("시장 전화번호 : \(market.marketPhonenum ?? "")")
                        .foregroundColor(.black)
                    
                    Text("Market Giftcard: \(market.marketGiftcard ?? "")")
                        .foregroundColor(.black)
                    
                    
                }
                
            }
                        
            Button(action: {
                isWritingReview = true
            }, label: {
                Text("리뷰 작성하기")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .padding()
            
        }.sheet(isPresented: $isWritingReview, content: {
            // Present the view for writing a review
            StoreReviewPostView(store: store)
        }
        )
        
    }
}



