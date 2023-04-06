//
//  StoreView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/06.
//

import SwiftUI

struct StoreView: View {
    
    var store: FoodItem
    
    var body: some View {
        ScrollView{
            
            ProductTopView() //장바구니 아이콘
            
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
                    .font(.system(size: 24))
                    .padding(.leading, 10)
                
                Spacer().frame(height: 10)
                
                Text("\(fooditem.storeName) 둘러보기 >")
                    .font(.system(size: 24))
                    .padding(.leading, 10)
                
                Spacer().frame(height: 20)
                
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
                        .background(Color.green)
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
                
                Spacer().frame(height: 20)

                Text(" 📉 가격변동추이")
                    .font(.system(size: 22))
                    .padding(.leading, 10)
            }
            //가격변동그래프 만들어야함. 가격추이를 저장해서 가져와야함
            // 장바구니 담기 -> 장바구니에 현재 페이지에 해당하는 상품이 담겨야함
            // 장바구니에 들어갈 애들은 데이터셋을 따로 저장해야하나..?

        }
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
