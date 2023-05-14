////
////  StoreListView.swift
////  MarketGo
////
////  Created by 김주현 on 2023/05/05.
////
//
//import SwiftUI
//
//struct StoreListView: View {
//    @State var stores: [StoreElement] = []
//    @State var marketId: Int = 17
//    @ObservedObject var storeModel = StoreViewModel()
//    @State private var searchText = ""
//    @StateObject var goodsViewModel = GoodsViewModel() // 상품 정보 뷰 모델
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                HStack {
//                    TextField("시장 이름으로 검색", text: $searchText)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                    Image(systemName: "magnifyingglass")
//                }
//                .padding(.horizontal, 16)
//                .padding(.top, 16)
//
//                Divider()
//
//                LazyVStack {
//                    ForEach(storeModel.stores.sorted { $0.ratings > $1.ratings }.filter {
//                        searchText.isEmpty ? true : $0.name.contains(searchText)
//                    }, id: \.id) { store in
//                        NavigationLink(destination: StoreView(store: store)) {
//                            HStack {
//                                VStack {
//                                    if let fileData = store.fileData {
//                                        URLImage(url: URL(string: fileData.uploadFileURL))
//                                    } else {
//                                        Text("Loading...")
//                                    }
//                                }
//                                .onAppear {
//                                    viewModel.getFileData(fileId: store.file)
//                                }
//
//                                VStack(alignment: .leading, spacing: 10) {
//                                    Text(store.name)
//                                        .font(.headline)
//                                        .foregroundColor(.black)
//
//                                    Text("작성된 리뷰 \(store.ratings)개 > ")
//                                        .font(.subheadline)
//                                        .foregroundColor(.black)
//                                }
//                                Spacer()
//                                HStack {
//                                    Image(systemName: "star.fill")
//                                        .foregroundColor(.yellow)
//                                    Text(String(format: "%.1f", store.ratings))
//                                        .font(.subheadline)
//                                        .foregroundColor(.black)
//                                }
//                            }
//                            .padding()
//                            
//                            // Display goods information for the store
//                            VStack(alignment: .leading) {
//                                if let goodsStore = store.storeMarketID {
//                                    Text("상품 정보:")
//                                        .font(.headline)
//                                        .foregroundColor(.black)
//                                        .padding(.top)
//                                    ForEach(goodsViewModel.goods.filter { $0.goodsStore?.storeID == goodsStore.storeID }, id: \.id) { goods in
//                                        Text(goods.goodsName ?? "")
//                                            .foregroundColor(.black)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .onAppear {
//                storeModel.fetchStores(marketId: marketId)
//                goodsViewModel.fetchGoods(forStoreMarketID: marketId)
//            }
//        }
//    }
//}
