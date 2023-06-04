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
                
                Text(goods.goodsName ?? "")
                    .font(.system(size: 26, weight: .bold))
                    .padding(.leading, 10)
                
                Spacer().frame(height: 10)
                
                Text("\((goods.goodsUnit)!) \(goods.goodsPrice ?? 0)원")
                    .font(.system(size: 20))
                    .padding(.leading, 10)
               
                Spacer().frame(height: 10)
                
                
            
                NavigationLink(destination: StoreView(store: goods.goodsStore!)) {
                    Text("\(goods.goodsStore?.storeName ?? "") 둘러보기 >")
                        .font(.system(size: 20))
                        .padding(.leading, 10)
                }

                Spacer().frame(height: 20)
                
                VStack(){
                    PriceGraphView();
                }
                
                
            }
            
        }
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
    }
}

struct RoundedButton: View {
   var imageName: String
   var text: String
   var body: some View {
   HStack {
      Image(systemName: imageName).font(.title)
      Text(text).fontWeight(.semibold).font(.title3)
   }.padding().foregroundColor(.white).background(Color.orange)
.cornerRadius(40)
}}
