import SwiftUI

struct MartPriceListView: View {
    @StateObject private var viewModel = MartPriceViewModel()
    @State var goodsName: String = "등심" // Set an initial value

    var body: some View {
        VStack {
            Text("Goods Name: \(goodsName)")
                .font(.headline)
                .padding()

            List(viewModel.martPrice) { price in
                VStack(alignment: .leading) {
                    Text("Price ID: \(price.martPriceID ?? 0)")
                        .font(.headline)
                    Text("Goods Name: \(price.goodsName ?? "")")
                        .font(.subheadline)
                    Text("Price: \(price.price ?? 0)")
                        .font(.subheadline)
                    Text("Unit: \(price.source ?? "")")
                        .font(.subheadline)
                    Text("Update Time: \(price.updateTime ?? "")")
                        .font(.subheadline)
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchMartPrice(goodsName: goodsName)
        }
    }
}

struct MartPriceListView_Previews: PreviewProvider {
    static var previews: some View {
        MartPriceListView()
    }
}
