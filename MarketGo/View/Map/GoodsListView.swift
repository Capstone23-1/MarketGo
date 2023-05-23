//import SwiftUI
//
//struct GoodsListView: View {
//    @StateObject var storeModel = StoreViewModel()
//    @StateObject var goodsVM = GoodsViewModel()
//    @State private var searchText = ""
//    @EnvironmentObject var marketModel: MarketModel
//
//    var body: some View {
//        ScrollView {
//            // 시장 이름으로 검색하는 텍스트 필드와 검색 아이콘을 포함하는 수평 스택
//            HStack {
//                TextField("시장 이름으로 검색", text: $searchText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                Image(systemName: "magnifyingglass")
//            }
//            .padding(.horizontal, 16)
//            .padding(.top, 16)
//
//            Divider()
//
//            LazyVStack {
//                // 가게 목록을 표시하는 반복문
//                ForEach(goodsVM.goods.sorted { $0.goodsStore?.storeID ?? 0 > $1.goodsStore?.storeID ?? 0 }.filter {
//                    // 검색 필터링을 적용하여 검색어와 일치하는 가게만 표시
//                    searchText.isEmpty ? true : $0.storeName?.contains(searchText) ?? false
//                }) { store in
//                    NavigationLink(destination: StoreView(store: store)) {
//                        HStack {
//                            HStack {
//                                // 가게 이미지 표시
//                                if let fileData = store.storeFile, let uploadFileURL = fileData.uploadFileURL, let url = URL(string: uploadFileURL) {
//                                    URLImage(url: url)
//                                } else {
//                                    Text("Loading...")
//                                }
//                            }
//
//                            VStack(alignment: .leading, spacing: 10) {
//                                // 가게 이름 표시
//                                Text(store.storeName ?? "")
//                                    .font(.headline)
//                                    .foregroundColor(.black)
//
//                                // 작성된 리뷰 개수 표시
//                                Text("작성된 리뷰 \(store.reviewCount ?? 0)개 > ")
//                                    .font(.subheadline)
//                                    .foregroundColor(.black)
//                            }
//
//                            Spacer()
//
//                            HStack {
//                                // 가게 평점 아이콘
//                                Image(systemName: "star.fill")
//                                    .foregroundColor(.yellow)
//                                // 가게 평점 표시
//                                Text(String(format: "%.1f", store.storeRatings ?? 0))
//                                    .font(.subheadline)
//                                    .foregroundColor(.black)
//                            }
//                        }
//                        .padding()
//                    }
//                }
//            }
//        }
//        .onAppear {
//            // 해당 시장의 가게 및 상품 데이터 가져오기
//            storeModel.fetchStores(forMarketId: marketModel.currentMarket?.marketID ?? 0) // 원하는 시장의 marketId를 제공하세요
//            goodsVM.fetchMarketGoods(forStoreMarketID: marketModel.currentMarket?.marketID ?? 0) // 원하는 시장의 marketId를 제공하세요
//        }
//    }
//}
