//
//  FoodItemDetailView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/05.
//

import SwiftUI

struct FoodItemDetailView: View {
    var goods: GoodsOne
    @State private var quantity: Int = 1
    @State private var showNotification: Bool = false
    @EnvironmentObject var cartModel: CartModel // CartviewModel
    @EnvironmentObject var userModel: UserModel
    @State private var showCartNotification: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                GoodsImage(url: URL(string: goods.goodsFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo"))
                
                HStack{
                    Text(goods.goodsName ?? "")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    NavigationLink(destination: StoreView(store: goods.goodsStore!)) {
                        Text("\(goods.goodsStore?.storeName ?? "") 둘러보기 ")
                            .font(.system(size: 16))
                            .padding(15)
                    }
                }
                
                Spacer().frame(height: 25)
                
                VStack(alignment: .leading){
                    
                    Text("가격 : \(goods.goodsPrice ?? 0)원")
                        .font(.system(size: 16))
                        .padding(.leading, 10)
                   

                    Divider()
                    
                    Text("단위 : \((goods.goodsUnit)!)")
                        .font(.system(size: 16))
                        .padding(.leading, 10)
                    Divider()
                }
                
                
                VStack(alignment: .leading){
                    
                    Text("원산지 : \(goods.goodsOrigin ?? "")")
                        .font(.system(size: 16))
                        .padding(.leading, 10)
                    Divider()
                    
                    Text("상품 정보 : \(goods.goodsInfo ?? "")")
                        .font(.system(size: 16))
                        .padding(.leading, 10)
                    
                    Divider()
                
                    
                    if let dateString = goods.updateTime,
                       let date = extractDate(from: dateString) {
                        let formattedDate = formatDate(date)
                        Text("데이터 기준 일자 : \(formattedDate)")
                            .font(.system(size: 16))
                            .padding(.leading, 10)
                    }
                    
                    Divider()
                    
                }
                Spacer().frame(height: 20)
                
                VStack(alignment: .leading) {
                    Text("\(goods.goodsName ?? "") 가격 변동 추이 그래프")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 16))
                        .padding(.leading, 10)
                    PriceGraphView(goodsId: goods.goodsID ?? 0)
                }
                
                Spacer().frame(height: 40)
                
            }
            
        }
        
        HStack(alignment: .center){
            
            
            VStack(alignment: .center){
                Button(action: {
                    cartModel.addProduct(product: goods)
                    print(cartModel.cartItems)
                    cartModel.updateCartItemsOnServer(cartId: userModel.currentUser?.cartID?.cartID ?? 0)
                    showCartNotification = true
                }){
                   RoundedButton(imageName: "cart.badge.plus", text: "장바구니에 담기")
                }
            }.frame(maxWidth: .infinity)
            .alert(isPresented: $showCartNotification, content: {
                Alert(title: Text("장바구니에 담겼습니다."), message: nil, dismissButton: .default(Text("닫기")))
            })
            .navigationBarItems(trailing:
                NavigationLink(destination: CartView()) {
                    Image(systemName: "cart")
                        .padding(.horizontal)
                        .imageScale(.large)
                }
            )
            
            VStack(alignment: .center){
                NavigationLink(destination: MartPriceListView(goodsName: goods.goodsName ?? "")){
                    RoundedButton(imageName: "dollarsign", text: "마트 가격 비교")
                }
            }.frame(maxWidth: .infinity)
            
            
            Spacer()
        }

        
        
        
    }
    
    private func extractDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            return Calendar.current.startOfDay(for: date)
        }
        return nil
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
}

struct RoundedButton: View {
   var imageName: String
   var text: String
   var body: some View {
   HStack {
       Image(systemName: imageName).font(.title2)
       Text(text).font(.system(size: 13, weight: .bold))
    }.padding()
           .frame(width: 170, height: 60)
    .foregroundColor(.white)
    .background(Color.orange)
    .cornerRadius(20)
 
}}

