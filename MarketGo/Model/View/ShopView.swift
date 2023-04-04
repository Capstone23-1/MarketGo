//
//  ShopView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/04.
// mainView에서 장보기 탭

import SwiftUI

struct TopStoresView: View {
    let stores: [Store] = [
        Store(store_name: "Store A", address1: "123 Main St", store_ratings: 4.5, store_phone_num: "555-555-1234", card_avail: true, local_avail: false, reviewCnt: 10, products: [], store_num: 1, store_image: "store_a"),
        Store(store_name: "Store B", address1: "456 Elm St", store_ratings: 4.0, store_phone_num: "555-555-5678", card_avail: false, local_avail: true, reviewCnt: 20, products: [], store_num: 2, store_image: "store_b"),
        Store(store_name: "Store C", address1: "789 Maple St", store_ratings: 3.5, store_phone_num: "555-555-9012", card_avail: true, local_avail: true, reviewCnt: 5, products: [], store_num: 3, store_image: "store_c"),
        Store(store_name: "Store D", address1: "321 Oak St", store_ratings: 3.0, store_phone_num: "555-555-3456", card_avail: false, local_avail: false, reviewCnt: 15, products: [], store_num: 4, store_image: "store_d"),
        Store(store_name: "Store E", address1: "654 Cedar St", store_ratings: 2.5, store_phone_num: "555-555-7890", card_avail: true, local_avail: false, reviewCnt: 8, products: [], store_num: 5, store_image: "store_e")
    ]
    @State private var searchText = ""

    var topStores: [Store] {
        Array(stores.sorted { $0.reviewCnt > $1.reviewCnt }.prefix(5))
    }

    var filteredStores: [Store] {
        if searchText.isEmpty {
            return topStores
        } else {
            return topStores.filter { $0.store_name.contains(searchText) }
        }
    }

    var body: some View {
        VStack {
            TextField("Search store", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            List(filteredStores) { store in
                HStack {
                    Image(store.store_image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                    VStack(alignment: .leading) {
                        Text(store.store_name)
                            .font(.headline)
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", store.store_ratings))
                                .font(.subheadline)
                        }
                        Text("\(store.reviewCnt) reviews")
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}


struct TopStoresView_Previews: PreviewProvider {
    static var previews: some View {
        TopStoresView()
    }
}
