import SwiftUI

struct MartPriceListView: View {
    @StateObject var viewModel = MartPriceViewModel()
    let goodsName : String
    
    var body: some View {
        VStack {
            Text("마트가격 비교")
                .font(.system(size: 20, weight: .bold))
                .padding()
            
            List(viewModel.martPrice) { price in
                VStack(alignment: .leading) {
                    Text(price.goodsName ?? "")
                        .font(.headline)
                    Text("가격: \(price.price ?? 0)원")
                        .font(.subheadline)
                    Text("판매처: \(price.source ?? "")")
                        .font(.subheadline)
                    
                    if let dateString = price.updateTime,
                       let date = extractDate(from: dateString) {
                        let formattedDate = formatDate(date)
                        Text("기준 일자 : \(formattedDate)")
                            .font(.subheadline)
                    }
                }
            }
            .onAppear {
                viewModel.fetchMartPrice(goodsName: goodsName)
            }
        }
    }
    
    private func extractDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            return Calendar.current.startOfDay(for: date)
        }
        return nil
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일"
        return dateFormatter.string(from: date)
    }
}

struct MartPriceListView_Previews: PreviewProvider {
    static var previews: some View {
        MartPriceListView(goodsName: "참외")
    }
}
