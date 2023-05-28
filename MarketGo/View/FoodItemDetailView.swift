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
    @EnvironmentObject var cart: cart // CartviewModel
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                GoodsImage(url: URL(string: goods.goodsFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo"))
                
                Text(goods.goodsName ?? "")
                    .font(.system(size: 26, weight: .bold))
                    .padding(.leading, 10)
                
                Spacer().frame(height: 10)
                
                Text("가격: \(goods.goodsPrice ?? 0)원")
                    .font(.system(size: 20))
                    .padding(.leading, 10)
                
                Spacer().frame(height: 10)
                
                Text("\(goods.goodsStore?.storeName ?? "") 둘러보기 >")
                    .font(.system(size: 20))
                    .padding(.leading, 10)
                
                Spacer().frame(height: 20)
                
                

            }
        }
        VStack(alignment: .center){
            Button(action: {
                cart.addProduct(product: goods)
                print(cart.cartItems)
                cart.updateCartItemsOnServer(cartId: userModel.currentUser?.cartID?.cartID ?? 0)
            }){
               RoundedButton(imageName: "cart.badge.plus", text: "장바구니에 담기")
            }
        }.frame(maxWidth: .infinity)
    }
}

struct QuantitySelectionView: View {
    @Binding var quantity: Int
    var addToCart: () -> Void
    
    var body: some View {
        VStack {
            Text("물품 개수 선택")
                .font(.system(size: 20, weight: .bold))
                .padding()
            
            Stepper(value: $quantity, in: 1...10) {
                Text("개수: \(quantity)")
                    .font(.system(size: 16))
            }
            .padding()
            
            Button(action: {
                addToCart() // Call the addToCart closure to perform add to cart action
            }, label: {
                Text("장바구니에 추가")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
            })
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding()
    }
}
