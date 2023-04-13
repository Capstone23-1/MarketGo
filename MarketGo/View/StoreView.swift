//
//  StoreView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/06.
//

import SwiftUI

struct StoreView: View {

    var store: Store
    @State var menuitem: [FoodItem] = []
    
    init(store: Store){
        self.store = store
        self._menuitem = State(initialValue: store.products)
    }

    var body: some View {
        NavigationView(){
            
            ScrollView{

                VStack(alignment: .leading) {
                    Image(store.store_image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Spacer().frame(height: 20)
                    
                    VStack(alignment: .leading){
                        
                        Text("\(store.store_name)")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.leading, 10)

                        //Text(fooditem.storeName).font(.system(size: 20, weight: .bold))
                        Spacer().frame(height: 10)

                        Text("📍 \(store.address1)")
                            .font(.system(size: 16))
                            .padding(.leading, 10)

                        Spacer().frame(height: 10)
                    

                        Text("📞 \(store.store_phone_num)")
                            .font(.system(size: 16))
                            .padding(.leading, 10)

                        Spacer().frame(height: 10)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", store.store_ratings))
                                .font(.system(size: 16))
                            Text("작성된 리뷰 \(store.reviewCnt)개 > ")
                                .font(.system(size: 16))
                                .padding(.leading, 10)
                            
                            Spacer().frame(width: 30)
                            Button(action: {
                                // 버튼이 클릭되었을 때 수행할 액션
                            }, label: {
                                Text("지도")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            })
                            .frame(width: 30, height: 5)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(6)

                        }.padding(.leading, 10)

                        Spacer().frame(height: 30)
                        
                        
                        Text(" 📜 메뉴판")
                            .font(.system(size: 16))
                            .padding(.leading, 10)
                        
                        LazyVStack(spacing: 5){
                            ForEach(menuitem) { item in
                                MenuItemRow(fooditem: item)
                                    .listRowInsets(EdgeInsets(top:0, leading: 0, bottom:0, trailing: 0))
                                    .frame(height: 90)
                                
                            }
                            
                        }

                    }

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
