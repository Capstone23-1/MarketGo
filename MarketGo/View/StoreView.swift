
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
                
                VStack(){
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: StoreReviewListView(store: store)){
                            MiniCardView(title: "리뷰", iconName: "ellipsis.message.fill")
                        }
                        Spacer()
                        
                        NavigationLink(destination: MenuView(storeID: store.storeID ?? 0, storeName: store.storeName ?? "")) {
                            MiniCardView(title: "메뉴판" , iconName: "menucard.fill")
                        }
                        Spacer()
                    }
                 
                }
                
                let storeData = store

                VStack {
                    Section(header: Text("데이터 기준 일자: \(convertDate(from: storeData.storeMarketID?.updateTime ?? ""))").font(.footnote)) {
                        
                        CardView(title: "가게 이름", value: storeData.storeName ?? "", iconName: "house")
                        
                        CardView(title: "가게 주소", value: storeData.storeAddress1 ?? "", iconName: "mappin.and.ellipse")
                        
                        CardView(title: "가게 평점", value: String(format:"%.1f", storeData.storeRatings ?? 0.0), iconName: "star")
                        
                        CardView(title: "가게 정보", value: storeData.storeInfo ?? "", iconName: "info.circle")
                        
                        CardView(title: "시장 주차장 보유여부", value: storeData.storeMarketID?.parking ?? "", iconName: "car")
                        
                        CardView(title: "화장실", value: storeData.storeMarketID?.toilet ?? "", iconName: "person.crop.square")
                        
                        CardView(title: "가게 연락처", value: storeData.storePhonenum ?? "", iconName: "phone")
                        
                        CardView(title: "카드 결제", value:store.cardAvail ?? "", iconName: "creditcard")
                        
                        CardView(title: "지역 화폐 ", value:store.cardAvail ?? "", iconName: "creditcard")
                    }
                }
                
                .padding() // Adding padding for better spacing
                .background(Color.white)
  
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
            
        }.navigationTitle("\(store.storeName ?? "")")
            .sheet(isPresented: $isWritingReview, content: {
            // Present the view for writing a review
            StoreReviewPostView(store: store)
        }
        )
        
    }
        
}


struct MiniCardView: View {
    var title: String
    var iconName: String

    var body: some View {
        
        VStack{
            Spacer()
            
            HStack(alignment: .center) {
                Spacer()
                
                Image(systemName: iconName)
                    .foregroundColor(.blue)
                    .imageScale(.large)
                    .padding(.horizontal)
                
                
                VStack(alignment: .center) {
                    Text(title)
                        .font(.system(size: 15, weight: .bold))
                    
                }
                Spacer()
            }
            Spacer()
        }
        .frame(height: 50)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
        .padding(.leading, 3)
        .padding(.trailing, 3)
        .padding(.bottom, 2)
        
        
    }
}
