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
                
                HStack {
                    Button(action: {
                        // Show quantity selection view
                        quantity = 1 // Reset quantity to default value
                        showNotification = false // Reset showNotification to false
                    }, label: {
                        Text("장바구니 담기")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    })
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .onTapGesture {
                        showNotification = true // Show notification when item is added to cart
                    }
                    
                    Spacer()
                }
                
                Spacer().frame(height: 20)
            }
        }
        .sheet(isPresented: $showNotification, content: {
            QuantitySelectionView(quantity: $quantity, addToCart: {
                // Perform add to cart action
                showNotification = true // Show notification when item is added to cart
            })
        })
        .alert(isPresented: $showNotification, content: {
            Alert(title: Text("Notification"), message: Text("물품이 장바구니에 추가되었습니다."), dismissButton: .default(Text("확인")))
        })
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
