//
//  StoreView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/06.
//

import SwiftUI

struct StoreView: View {

    var store: Store

    var body: some View {
        ScrollView{

            ProductTopView() //장바구니 아이콘

            VStack(alignment: .leading) {

                Image(store.store_image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)


                Text(store.store_name)
                    .font(.system(size: 30, weight: .bold))
                    .padding(.leading, 10)

                //Text(fooditem.storeName).font(.system(size: 20, weight: .bold))
                Spacer().frame(height: 10)

                Text(store.address1)
                    .font(.system(size: 24))
                    .padding(.leading, 10)

                Spacer().frame(height: 10)

                Text(store.store_phone_num)
                    .font(.system(size: 24))
                    .padding(.leading, 10)

                Spacer().frame(height: 20)

            }

        }
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView(store: Store.stores[0])
    }
}
