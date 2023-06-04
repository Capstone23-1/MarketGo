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
                    .frame(height: 200)
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

    var body: some View {
        GeometryReader { geometry in
            let xScale = geometry.size.width / CGFloat(data.count - 1)
            let yScale = geometry.size.height / CGFloat(maxPrice)

            Path { path in
                for (index, datum) in data.enumerated() {
                    let x = CGFloat(index) * xScale
                    let y = geometry.size.height - CGFloat(datum.price ?? 0) * yScale

                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                    
                    // Display price at each data point
                    Text("\(datum.price ?? 0)")
                        .font(.caption)
                        .position(x: x, y: y - 20) // Adjust the position based on your preference
                }
            }
            .stroke(Color.blue, lineWidth: 2)

            // Draw labels
            ForEach(data, id: \.goodsDataID) { datum in
                let x = CGFloat(data.firstIndex(where: { $0.goodsDataID == datum.goodsDataID }) ?? 0) * xScale

                Text(datum.updatedDate ?? "")
                    .font(.caption)
                    .position(x: x, y: geometry.size.height)
            }
        }
    }
}




struct PriceGraphView_Previews: PreviewProvider {
    static var previews: some View {
        PriceGraphView()
    }
}
