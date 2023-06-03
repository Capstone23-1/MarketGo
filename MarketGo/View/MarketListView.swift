import Foundation
import SwiftUI

struct MarketListView: View {
    @Binding var marketData: MarketOne?
    
    @available(iOS 15.0, *)
    var body: some View {
        List {
            if let marketData = marketData {
                Section(header: Text("데이터 기준 일자: \(convertDate(from: marketData.updateTime!))").font(.footnote)) {

                    CardView(title: "시장 이름", value: marketData.marketName ?? "", iconName: "house")

                    CardView(title: "주소", value: marketData.marketAddress1 ?? "", iconName: "mappin.and.ellipse")

                    CardView(title: "평점", value: String(format:"%.1f", marketData.marketRatings ?? 0.0), iconName: "star")

                    CardView(title: "상세 정보", value: marketData.marketInfo ?? "", iconName: "info.circle")

                    CardView(title: "주차장 보유여부", value: marketData.parking ?? "", iconName: "car")
                    CardView(title: "화장실", value: marketData.toilet ?? "", iconName: "person.crop.square")
                        

                    CardView(title: "시장 연락처", value: marketData.marketPhonenum ?? "", iconName: "phone")
                        

                    CardView(title: "지역화페", value: marketData.marketGiftcard ?? "", iconName: "creditcard")
                        
                }
            } else {
                Text("데이터를 불러오는 데 실패했습니다.")
                    .foregroundColor(.red)
                    .font(.headline)
            }
        }
        .listStyle(GroupedListStyle())
        .background(Color.white)
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

struct CardView: View {
    var title: String
    var value: String
    var iconName: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.blue)
                .imageScale(.large)
                .padding(.horizontal)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(minHeight: 60)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}
