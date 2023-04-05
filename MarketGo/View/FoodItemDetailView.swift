//
//  FoodItemDetailView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/05.
//

import SwiftUI

struct FoodItemDetailView: View {
    var fooditem: FoodItem
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Image(fooditem.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            
            Text(fooditem.name)
                .font(.system(size: 30, weight: .bold))
                .padding(.leading, 10)
            
            //Text(fooditem.storeName).font(.system(size: 20, weight: .bold))
            Spacer().frame(height: 10)
            
            Text("\(fooditem.price)원")
                .font(.system(size: 30))
                .padding(.leading, 10)
            
            Spacer().frame(height: 10)
            
            Text("\(fooditem.storeName) 둘러보기 >")
                .font(.system(size: 25))
                .padding(.leading, 10)
            
            Spacer().frame(height: 10)
            HStack {
                    Spacer()
                    Button(action: {
                        // 버튼이 클릭되었을 때 수행할 액션
                    }, label: {
                        Text("사장님과 채팅")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    })
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)

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
        }
        
    }
}

struct FoodItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemDetailView(fooditem: FoodItem.foodItems[0])
    }
}
