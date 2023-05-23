//
//  FoodItemDetailView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/05.
//

import SwiftUI



struct FoodItemDetailView: View {
    var goods: GoodsOne
    
    var body: some View {
        ScrollView{
            
            VStack(alignment: .leading) {
                
                GoodsImage(url: URL(string: goods.goodsFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo"))
                
                Text(goods.goodsName ?? "")
                    .font(.system(size: 26, weight: .bold))
                    .padding(.leading, 10)
                
                //Text(fooditem.storeName).font(.system(size: 20, weight: .bold))
                Spacer().frame(height: 10)
                
                Text("가격: \(goods.goodsPrice ?? 0)원")
                    .font(.system(size: 20))
                    .padding(.leading, 10)
                
                Spacer().frame(height: 10)
                
                Text("\(goods.goodsStore?.storeName ?? "") 둘러보기 >")
                    .font(.system(size: 20))
                    .padding(.leading, 10)
                
                Spacer().frame(height: 20)
                
                HStack {
                    Button(action: {
                        // 버튼이 클릭되었을 때 수행할 액션
                    }, label: {
                        Text("장바구니 담기")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    })
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    Spacer()
                    }
                
                Spacer().frame(height: 20)

              
            }
           
        }

    }
    
}


