//
//  CartView.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import SwiftUI

struct CartView: View {
    @State private var foodItems = [FoodItem(name: "사과 ", storeName: "영찬과일", price: 12000),
                                        FoodItem(name: "참외", storeName: "주현싱싱", price: 1100),
                                        FoodItem(name: "수박", storeName: "소람싱싱", price: 18000)]
    
    var body: some View {
        VStack {
            List {
                ForEach(foodItems.indices) { index in
                    let foodItem = foodItems[index]
                    HStack {
                        Text(foodItem.name)
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(foodItem.price)원")
                            .foregroundColor(.gray)
                        Stepper(value: $foodItems[index].quantity, in: 1...10) {
                            Text("\(foodItem.quantity) 개")
                        }
                    }
                }
            }
            Spacer()
            HStack {
                Text("총 가격: ")
                    .fontWeight(.semibold)
                Text("\(foodItems.map { $0.price * $0.quantity }.reduce(0, +))원")
            }
        }
        .navigationBarTitle("장바구니")
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
