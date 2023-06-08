import Foundation
import SwiftUI

struct MarketInfoList: View {
    @Binding var marketData: MarketOne?

    var body: some View {
        if let marketData = marketData {
            ScrollView {
                VStack {
                    Section(header: Text("마지막 업데이트 \(convertDate(from: marketData.updateTime!))").font(.footnote)) {

                        CardView(title: "시장 이름", value: marketData.marketName ?? "", iconName: "house")

                        CardView(title: "주소", value: marketData.marketAddress1 ?? "", iconName: "mappin.and.ellipse")

                        CardView(title: "평점", value: String(format:"%.1f", marketData.marketRatings ?? 0.0), iconName: "star")

                        CardView(title: "상세 정보", value: marketData.marketInfo ?? "", iconName: "info.circle")

                        CardView(title: "주차장 보유여부", value: marketData.parking ?? "", iconName: "car")

                        CardView(title: "화장실", value: marketData.toilet ?? "", iconName: "person.crop.square")

                        CardView(title: "시장 연락처", value: marketData.marketPhonenum ?? "", iconName: "phone")

                        CardView(title: "지역화페", value: marketData.marketGiftcard ?? "", iconName: "creditcard")
                    }
                }
            }
            .padding() // Adding padding for better spacing
            .background(Color.white)
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

