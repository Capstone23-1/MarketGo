//
//  StoreView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/06.
//

import SwiftUI

struct StoreView: View {
    let store: Store

    @StateObject var fileModel = FileDataViewModel() // 이미지 파일 구조체
    @StateObject var goodsViewModel2 = GoodsViewModel2() // 상품 가져올 구조체
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    VStack {
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
                        fileModel.getFileData(fileId: store.file)
                    }
                    
                    Spacer().frame(height: 20)
                    
                    VStack(alignment: .leading) {
                        Text("\(store.name)")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.leading, 10)

                        Spacer().frame(height: 10)

                        Text("📍 \(store.address1)")
                            .font(.system(size: 16))
                            .padding(.leading, 10)

                        Spacer().frame(height: 10)

                        Text("📞 \(store.phoneNumber)")
                            .font(.system(size: 16))
                            .padding(.leading, 10)

                        Spacer().frame(height: 10)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", store.ratings))
                                .font(.system(size: 16))
                            Text("작성된 리뷰 \(store.ratings)개 > ")
                                .font(.system(size: 16))
                                .padding(.leading, 10)
                            
                            Spacer().frame(width: 30)
                            Button(action: {
                                // 버튼이 클릭되었을 때 수행할 액션
                            }, label: {
                                Text("지도")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            })
                            .frame(width: 30, height: 5)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(6)
                        }
                        .padding(.leading, 10)

                        Spacer().frame(height: 30)

                        Text("📜 메뉴판")
                            .font(.system(size: 16))
                            .padding(.leading, 10)
                        
                        LazyVStack(spacing: 5) {
                            ForEach(goodsViewModel2.goods) { item in
                                MenuItemRow(goods: item)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    .frame(height: 90)
                            }
                        }
                    }
                }
            }
            .onAppear {
                goodsViewModel2.fetchGoods(goodsMarket: store.marketId, goodsStore: store.id)
            }
        }
    }
}

//struct StoreView_Previews: PreviewProvider {
//    static var previews: some View {
//       
//    }
//}
