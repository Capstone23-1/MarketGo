//
//  FoodItemCell.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/04.
//

import SwiftUI

struct FoodItemCell: View {
    var fooditem: FoodItem
    
    var body: some View {
        VStack {
            Image(fooditem.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            
            Text(fooditem.name)
                .font(.system(size: 16, weight: .bold))
            Text(fooditem.storeName).font(.system(size: 11, weight: .bold))
            Text("가격 : \(fooditem.price)원").font(.system(size: 11))
            Spacer()
        }
    }
}

struct FoodItemCell_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemCell(fooditem: FoodItem.foodItems[0])
            .previewLayout(.fixed(width: 160, height: 250))
    }
}
