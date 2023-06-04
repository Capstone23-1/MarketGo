
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
    
    func convertDate(from string: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = inputFormatter.date(from: string) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy.MM.dd"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid date"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView{
                VStack(alignment: .leading) {
                    
                    GoodsImage(url: URL(string: store.storeFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo"))
                    
                }
                
                if let storeData = store {

                        VStack {
                            Section(header: Text("데이터 기준 일자: \(convertDate(from: storeData.storeMarketID?.updateTime ?? ""))").font(.footnote)) {

                                CardView(title: "시장 이름", value: storeData.storeMarketID?.marketName ?? "", iconName: "house")

                                CardView(title: "주소", value: storeData.storeMarketID?.marketAddress1 ?? "", iconName: "mappin.and.ellipse")

                                CardView(title: "가게 평점", value: String(format:"%.1f", storeData.storeRatings ?? 0.0), iconName: "star")

                                CardView(title: "가게 정보", value: storeData.storeInfo ?? "", iconName: "info.circle")

                                CardView(title: "시장 주차장 보유여부", value: storeData.storeMarketID?.parking ?? "", iconName: "car")

                                CardView(title: "화장실", value: storeData.storeMarketID?.toilet ?? "", iconName: "person.crop.square")

                                CardView(title: "가게 연락처", value: storeData.storePhonenum ?? "", iconName: "phone")

                                CardView(title: "지역화페", value:storeData.storeMarketID?.marketGiftcard ?? "", iconName: "creditcard")
                            }
                        }
                    
                    .padding() // Adding padding for better spacing
                    .background(Color.white)
                } else {
                    Text("데이터를 불러오는 데 실패했습니다.")
                        .foregroundColor(.red)
                        .font(.headline)
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


