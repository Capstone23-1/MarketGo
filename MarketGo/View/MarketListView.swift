import Foundation
import SwiftUI

struct MarketListView: View {
    @Binding var marketData: MarketOne?
    
    var body: some View {
        NavigationView {
            List {
                if let marketData = marketData {
                    Section(header: Text("데이터 기준 일자: \(convertDate(from: marketData.updateTime!))").font(.headline)) {
                        DetailRow(title: "마켓ID", detail: "\(marketData.marketID)")
                        DetailRow(title: "시장 이름", detail: marketData.marketName ?? "")
                        DetailRow(title: "주소", detail: marketData.marketAddress1 ?? "")
                        DetailRow(title: "평점", detail: String(format:"%.1f", marketData.marketRatings ?? 0.0))
                        DetailRow(title: "상세 정보", detail: marketData.marketInfo ?? "")
                        DetailRow(title: "주차장 보유여부", detail: marketData.parking ?? "")
                        DetailRow(title: "화장실", detail: marketData.toilet ?? "")
                        DetailRow(title: "전화번호", detail: marketData.marketPhonenum ?? "")
                        DetailRow(title: "지역화페", detail: marketData.marketGiftcard ?? "")
                    }
                } else {
                    Text("데이터를 불러오는 데 실패했습니다.")
                        .foregroundColor(.red)
                        .font(.headline)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("시장 정보")
        }
    }
    
    func convertDate(from string: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = inputFormatter.date(from: string) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy.MM.dd"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid date"
        }
    }
}

struct DetailRow: View {
    var title: String
    var detail: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(detail)
                .foregroundColor(.secondary)
        }
    }
}
