//
//  MenuItemRow.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/09.
//

import SwiftUI


struct MenuItemRow: View {
    var goods: Goods
    
    @StateObject var fileModel = FileDataViewModel()
    
    var body: some View {
        
        HStack {
            VStack {
                //서버에서 이미지 받아오기
                if let fileData = fileModel.fileData {
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
                fileModel.getFileData(fileId: goods.goodsFile)
            }
        
            Spacer().frame(width:20)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("\(goods.goodsName)")
                    .font(.system(size: 17))
                
                HStack {
                    Text("\(goods.goodsPrice) 원")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(.gray)
                
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
}

struct MenuItemRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemRow(goods: Goods(id: 1, goodsName: "Food Item", goodsMarket: 1, goodsStore: 1, goodsFile: 1, goodsPrice: 10, goodsUnit: "unit", goodsInfo: "Info", goodsOrigin: "Origin", isAvail: 1))
    }
}
