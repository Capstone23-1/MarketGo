//
//  FoodItemListView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import SwiftUI

struct FoodItemListView: View {
    
    @State var foodlist : [FoodItem] = FoodItem.foodItems
    @State private var searchText = ""
    @State private var placeHolder: String = "시장 또는 물품 검색"
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: layout){
                    ForEach(foodlist) { item in
                        NavigationLink(destination: FoodItemDetailView(fooditem: item)){
                            FoodItemCell(fooditem: item)
                                .foregroundColor(.black)
                        }
                        
                    }
                }
                .padding([.top, .leading, .trailing],16.0)
            }
        }
        
        
        
    }
}

struct FoodItemListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemListView()
    }
}
