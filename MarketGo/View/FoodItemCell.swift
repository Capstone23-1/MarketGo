//
//  FoodItemCell.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/04.
//

import SwiftUI

struct FoodItemCell: View {
    var goods: Good
    @StateObject var fileModel = FileDataViewModel() //이미지파일 구조체
    
    var body: some View {
        VStack {
            VStack {
                if let fileData = fileModel.fileData {

                    //Text("Original File Name: \(fileData.originalFileName)")
                    //Text("Upload File Name: \(fileData.uploadFileName)")
                    
                    Image(fileData.originalFileName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .cornerRadius(4)
            
                } else {
                    Text("Loading...")
                }
            }
            .onAppear {
                fileModel.getFileData(fileId: 0)
            }
 
            
            Text(goods.goodsName ?? "")
                .font(.system(size: 16, weight: .bold))
            Text(goods.goodsStore?.storeName ?? "").font(.system(size: 11, weight: .bold))
            Text("가격 : \(goods.goodsPrice ?? 0)원").font(.system(size: 11))
            Spacer()
        }
    }
}

//
//struct FoodItemCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodItemCell(goods: Goods.example)
//            .previewLayout(.fixed(width: 160, height: 250))
//    }
//}
