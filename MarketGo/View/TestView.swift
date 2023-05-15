import SwiftUI

struct TestView: View {
    @ObservedObject private var goodsViewModel = GoodsViewModel2()
    let storeID: Int // Store ID

    var body: some View {
        VStack {
            if !goodsViewModel.goods.isEmpty {
                List(goodsViewModel.goods) { good in
                    VStack(alignment: .leading) {
                        Text(good.goodsName ?? "")
                            .font(.headline)
                        Text(good.goodsInfo ?? "")
                            .font(.subheadline)
                    }
                }
            } else {
                Text("No menu items available")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            goodsViewModel.fetchGoods(forGoodsStoreID: storeID)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(storeID: 4) // Replace with an actual store ID for preview
    }
}
