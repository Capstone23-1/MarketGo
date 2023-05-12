//
//  ShopView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/04.
//  mainView에서 장보기 탭


import SwiftUI

struct ShopView: View {
    @ObservedObject var storeModel = StoreViewModel()
    @ObservedObject var goodsModel = GoodsViewModel()
    
    @StateObject var fileModel = FileDataViewModel() //이미지파일 구조체
    @State var marketId : Int = 17
    @State private var searchText = ""
    @State private var placeHolder: String = "시장 또는 물품 검색"
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var topStores: [Store] {
        Array(storeModel.stores.sorted { $0.ratings > $1.ratings }.prefix(3))
       }

       var filteredStores: [Store] {
           if searchText.isEmpty {
               return topStores
           } else {
               return topStores.filter { $0.name.contains(searchText) }
           }
       }
    
        var body: some View {
            NavigationView { // NavigationView 추가
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading){
                        
                        
                        SearchBar(searchText: $searchText, placeHolder: $placeHolder)
                        Spacer()
                        
                        ScrollView { // ScrollView 추가
                            Spacer()
                            
                            HStack{
                                
                                Text("가게 랭킹 top3 (리뷰 많은 순) ")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                Spacer()
                                NavigationLink(destination: StoreListView()){
                                    Text("가게 더보기 > ")
                                        .foregroundColor(.black)
                                        .padding(.horizontal)
                                }
                            }

                            
                            LazyVStack { // LazyVStack 사용
                                ForEach(filteredStores, id: \.id) { store in
                                    NavigationLink(destination: StoreView(store: store)){

                                        
                                        HStack {
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
                                                fileModel.getFileData(fileId: store.file)
                                            }

                                            VStack(alignment: .leading, spacing: 10) {
                                                Text(store.name)
                                                    .font(.headline)
                                                    .foregroundColor(.black)
                                                
                                                Text("작성된 리뷰 \(store.ratings)개 > ")
                                                    .font(.subheadline)
                                                    .foregroundColor(.black)
                                            }
                                            Spacer()
                                            HStack {
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.yellow)
                                                Text(String(format: "%.1f", store.ratings))
                                                    .font(.subheadline)
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        .padding() // 각 셀에 패딩 추가
                                        
                                    }
                                    
                                }
                            }
                            
                    }
                  
                }.onAppear {
                    storeModel.fetchStores(marketId: marketId)
                }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("상품 >")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            Spacer()
                            NavigationLink(destination: StoreListView()) {
                                Text("상품 더보기 >")
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                            }
                        }

                        LazyVGrid(columns: layout) {
                            ForEach(goodsModel.goods) { item in
                                NavigationLink(destination: FoodItemDetailView(goods: item)) {
                                    FoodItemCell(goods: item)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .padding([.top, .leading, .trailing], 16.0)
                    }
                    .onAppear {
                        goodsModel.fetchGoods(forStoreMarketID: 17)
                    }
                    
                }
                .navigationBarHidden(true) // 네비게이션 바 숨김
                
            }
            
        }
}


struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}



