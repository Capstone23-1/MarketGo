//
//  PriceGraphView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/06/01.
//
import SwiftUI
import Foundation

// MARK: - GoodsDatum
struct GoodsDatum: Codable {
    var goodsDataID: Int?
    var goodsID, price: Int?
    var updatedDate: String?

    enum CodingKeys: String, CodingKey {
        case goodsDataID = "goodsDataId"
        case goodsID = "goodsId"
        case price, updatedDate
    }
}

typealias GoodsData = [GoodsDatum]

struct PriceGraphView: View {
    @State private var goodsData: GoodsData = []
    @State private var goodsId: Int = 26
    
    var body: some View {
        VStack {
            if !goodsData.isEmpty {
                LineChartView(data: goodsData)
                    .frame(height: 100)
                    .padding()
            } else {
                ProgressView() // Show a loading indicator while data is being fetched
            }
        }
        .onAppear {
            fetchData(forGoodsId: goodsId)
        }
    }
    
    func fetchData(forGoodsId goodsId: Int) {
        guard let url = URL(string: "http://3.34.33.15:8080/goodsData/\(goodsId)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    self.goodsData = try decoder.decode(GoodsData.self, from: data)
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }
        
        task.resume()
    }
}

struct LineChartView: View {
    let data: GoodsData
    
    // Compute the maximum price from the data
    var maxPrice: Double {
        Double(data.map { $0.price ?? 0 }.max() ?? 0)
    }
    
    // Compute the offset for adjusting the x-coordinate values
    var xOffset: CGFloat {
        let spacing: CGFloat = 20 // Adjust the spacing value based on your preference
        let screenWidth = UIScreen.main.bounds.width
        let contentWidth = CGFloat(data.count - 1) * xScale
        let remainingSpace = screenWidth - contentWidth
        return remainingSpace > spacing ? remainingSpace / 2 : spacing
    }
    
    // Compute the x-scale based on the geometry size and data count
    var xScale: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return screenWidth / CGFloat(data.count - 1)
    }

    var body: some View {
        GeometryReader { geometry in
            let yScale = geometry.size.height / CGFloat(maxPrice)
            
            Path { path in
                for (index, datum) in data.enumerated() {
                    let x = CGFloat(index) * xScale + xOffset
                    let y = geometry.size.height - CGFloat(datum.price ?? 0) * yScale

                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .stroke(Color.blue, lineWidth: 2)
            
            ForEach(data, id: \.goodsDataID) { datum in
                let x = CGFloat(data.firstIndex(where: { $0.goodsDataID == datum.goodsDataID }) ?? 0) * xScale + xOffset

                if let dateString = datum.updatedDate,
                   let date = extractDate(from: dateString) {
                    let formattedDate = formatDate(date)
                    
                    Text(formattedDate)
                        .font(.caption)
                        .position(x: x, y: geometry.size.height + 10) // Adjust the y-position based on your preference
                    
                    if let price = datum.price {
                        Text("\(price)원")
                            .font(.caption)
                            .position(x: x, y: geometry.size.height - CGFloat(price) * yScale - 20) // Adjust the y-position based on your preference
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
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
        dateFormatter.dateFormat = "yyyy\nMM/dd"
        return dateFormatter.string(from: date)
    }
}


struct PriceGraphView_Previews: PreviewProvider {
    static var previews: some View {
        PriceGraphView()
    }
}
