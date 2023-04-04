//
//  CartView.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import SwiftUI

struct CartView: View {
    @State private var foodItems = [FoodItem(name: "사과 ", storeName: "영찬과일", imageName: "apple", price: 12000, store_num: 1),
                                        FoodItem(name: "참외", storeName: "주현싱싱", imageName: "melon", price: 1100,store_num: 2),
                                        FoodItem(name: "수박", storeName: "소람싱싱", imageName: "watermelon", price: 18000,store_num: 3)]
    
    var body: some View {
        VStack {
            List {
                ForEach(foodItems.indices, id: \.self) { index in
                    let foodItem = foodItems[index]
                    HStack() {
                        VStack(alignment: .leading){
                            Image("\(foodItem.imageName)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:80, height: 80)
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 5){
                            Text(foodItem.name)
                                .fontWeight(.semibold)
                            Text(foodItem.storeName).font(.system(size: 14))
                            Text("\(foodItem.price)원")
                               .foregroundColor(.gray)
                        }
                        
                        Stepper(value: $foodItems[index].quantity, in: 1...10) {
                            Text("\(foodItem.quantity) 개")
                        }
                    }
                }
                .onDelete(perform: deleteItem)
            }
            Spacer()
            HStack {
                Text("총 가격: ")
                    .fontWeight(.semibold)
                Text("\(foodItems.map { $0.price * $0.quantity }.reduce(0, +))원")
            }
        }
        .navigationBarTitle("장바구니")
        .navigationBarItems(trailing: EditButton())
    }
    
    func deleteItem(at offsets: IndexSet) {
        foodItems.remove(atOffsets: offsets)
    }
}


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
