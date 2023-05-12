
import SwiftUI
import Alamofire



struct TestView: View {
    @ObservedObject var viewModel = GoodsViewModel()

    var body: some View {
        List(viewModel.goods, id: \.goodsID) { good in
            VStack(alignment: .leading) {
                Text("ID: \(good.goodsID ?? 0)")
                Text("Name: \(good.goodsName ?? "")")
                // Add more views to display other properties as needed
            }
        }
        .onAppear {
            viewModel.fetchGoods(forStoreMarketID: 17)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
