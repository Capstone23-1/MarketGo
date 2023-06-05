import SwiftUI

struct MartPriceListView: View {
    @StateObject var viewModel = MartPriceViewModel()
    
    var body: some View {
        List(viewModel.martPrice) { price in
            VStack(alignment: .leading) {
                Text(price.goodsName ?? "")
                    .font(.headline)
                Text("가격: \(price.price ?? 0)원")
                    .font(.subheadline)
                Text("Source: \(price.source ?? "")")
                    .font(.subheadline)
            }
        }
        .onAppear {
            let goodsName = "참외" // 가져올 상품명 입력
            viewModel.fetchMartPrice(goodsName: goodsName)
        }
    }
}

struct MartPriceListView_Previews: PreviewProvider {
    static var previews: some View {
        MartPriceListView()
    }
}
