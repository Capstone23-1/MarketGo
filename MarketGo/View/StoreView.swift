//
//  StoreView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/06.
//

import SwiftUI

struct StoreView: View {

    var store: Store

    var body: some View {
        ScrollView{

            ProductTopView() //장바구니 아이콘

            VStack(alignment: .leading) {

                Image(store.store_image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer().frame(height: 20)
                
                VStack(alignment: .leading){
                    
                    Text("\(store.store_name)")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.leading, 10)

                    //Text(fooditem.storeName).font(.system(size: 20, weight: .bold))
                    Spacer().frame(height: 10)

                    Text("📍 \(store.address1)")
                        .font(.system(size: 20))
                        .padding(.leading, 10)

                    Spacer().frame(height: 10)

                    Text("📞 \(store.store_phone_num)")
                        .font(.system(size: 20))
                        .padding(.leading, 10)

                    Spacer().frame(height: 10)
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", store.store_ratings))
                            .font(.system(size: 20))
                        Text("작성된 리뷰 \(store.reviewCnt)개 > ")
                            .font(.system(size: 20))
                            .padding(.leading, 10)
                    }.padding(.leading, 10)
                    
                    Spacer().frame(height: 30)
                    
                    Text(" 📜 메뉴판")
                        .font(.system(size: 20))
                        .padding(.leading, 10)

                }

            }

        }
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView(store: Store.stores[0])
    }
}
