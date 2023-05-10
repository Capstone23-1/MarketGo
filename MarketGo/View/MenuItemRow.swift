////
////  MenuItemRow.swift
////  MarketGo
////
////  Created by 김주현 on 2023/04/09.
////
//
//import SwiftUI
//
//
//struct MenuItemRow: View {
//    var fooditem:FoodItem
//    
//    var body: some View {
//        
//        HStack {
//            Image("\(fooditem.imageName)")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 70, height: 70)
//            
//            Spacer().frame(width:20)
//            
//            VStack(alignment: .leading, spacing: 10) {
//                Text("\(fooditem.name)")
//                    .font(.system(size: 17))
//                
//                HStack {
//                    Text("\(fooditem.price) 원")
//                        .font(.system(size: 15))
//                        .foregroundColor(.gray)
//                }
//            }
//            
//            Spacer()
//            
//            Image(systemName: "heart.fill")
//                .resizable()
//                .renderingMode(.template)
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 25, height: 25)
//                .foregroundColor(.gray)
//                
//        }
//        .padding()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        }
//}
//
//struct MenuItemRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuItemRow(fooditem: Store.stores[0].products[0])
//    }
//}
