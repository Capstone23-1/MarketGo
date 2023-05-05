//
//  StoreListView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import SwiftUI

struct StoreListView: View {
    @State var stores: [Store] = Store.stores
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ScrollView {
               
                    HStack {
                        TextField("시장 이름으로 검색", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Image(systemName: "magnifyingglass")
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)

                    Divider()

                    LazyVStack {
                        ForEach(stores.sorted { $0.reviewCnt > $1.reviewCnt }.filter {
                            searchText.isEmpty ? true : $0.store_name.contains(searchText)
                        }, id: \.store_num) { store in
                            NavigationLink(destination: StoreView(store: store)) {
                                HStack {
                                    Image(store.store_image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 70, height: 70)
                                        .cornerRadius(4)

                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(store.store_name)
                                            .font(.headline)
                                            .foregroundColor(.black)

                                        Text("작성된 리뷰 \(store.reviewCnt)개 > ")
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                    }
                                    Spacer()
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        Text(String(format: "%.1f", store.store_ratings))
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                
            }
        }
    }
}



struct StoreListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreListView()
    }
}
