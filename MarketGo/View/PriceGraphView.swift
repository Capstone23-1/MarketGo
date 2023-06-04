////
////  PriceGraphView.swift
////  MarketGo
////
////  Created by 김주현 on 2023/06/01.
////
//
//import Charts
//import SwiftUI
//import SwiftUI
//import Foundation
//
//// MARK: - GoodsDatum
//struct GoodsDatum: Codable, Identifiable {
//    var goodsDataID: Int?
//    var goodsID, price: Int?
//    var updatedDate: String?
//
//    enum CodingKeys: String, CodingKey {
//        case goodsDataID = "goodsDataId"
//        case goodsID = "goodsId"
//        case price, updatedDate
//    }
//    
//    var id: Int{
//        return goodsDataID ?? 0
//    }
//}
//
//typealias GoodsData = [GoodsDatum]
//
//struct PriceGraphView: View {
//    @State private var goodsData: GoodsData = []
//    @State private var goodsId: Int = 26
//    
//    var body: some View {
//        VStack {
//            if !goodsData.isEmpty {
//                LocationsOverviewChart(data: goodsData)
//                    .frame(height: 200)
//                    .padding()
//            } else {
//                ProgressView() // Show a loading indicator while data is being fetched
//            }
//        }
//        .onAppear {
//            fetchData(forGoodsId: goodsId)
//        }
//    }
//    
//    func fetchData(forGoodsId goodsId: Int) {
//        guard let url = URL(string: "http://3.34.33.15:8080/goodsData/\(goodsId)") else {
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error: \(error)")
//                return
//            }
//            
//            if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    self.goodsData = try decoder.decode(GoodsData.self, from: data)
//                } catch {
//                    print("Error decoding data: \(error)")
//                }
//            }
//        }
//        
//        task.resume()
//    }
//}
//
//struct LocationsOverviewChart: View {
//    let symbolSize: CGFloat = 100
//    let lineWidth: CGFloat = 3
//    let data: GoodsData // Add a new property to hold the goods data
//
//    var body: some View {
//        Chart {
//            ForEach(data) { datum in // Use the provided goods data
//                if let dateString = datum.updatedDate,
//                   let date = extractDate(from: dateString),
//                   let price = datum.price {
//                    LineMark(
//                        x: .value("Day", date, unit: .day), // Use date as x-axis value
//                        y: .value("Sales", price) // Use price as y-axis value
//                    )
//                    .foregroundStyle(.purple) // Apply purple foreground style to all data points
//                    .symbol(Square().strokeBorder(lineWidth: lineWidth)) // Use square symbol shape with purple stroke border
//                }
//            }
//            .interpolationMethod(.catmullRom)
//            .lineStyle(StrokeStyle(lineWidth: lineWidth))
//            .symbolSize(symbolSize)
//
//            if let bestDatum = data.max(by: { $0.price ?? 0 < $1.price ?? 0 }) {
//                if let dateString = bestDatum.updatedDate,
//                   let date = extractDate(from: dateString),
//                   let price = bestDatum.price {
//                    PointMark(
//                        x: .value("Day", date, unit: .day), // Use date as x-axis value
//                        y: .value("Sales", price) // Use price as y-axis value
//                    )
//                    .foregroundStyle(.purple) // Apply purple foreground style to the best data point
//                    .symbolSize(symbolSize)
//                    .symbol(Square().strokeBorder(lineWidth: lineWidth)) // Use square symbol shape with purple stroke border
//                }
//            }
//        }
//        .chartXAxis {
//            AxisMarks(values: .stride(by: .day)) { _ in
//                AxisTick()
//                AxisGridLine()
//                AxisValueLabel(format: .dateTime.weekday(.narrow), centered: true)
//            }
//        }
//        .chartYAxis(.hidden)
//        .chartYScale(range: .plotDimension(endPadding: 8))
//        .chartLegend(.hidden)
//    }
//
//    private func extractDate(from dateString: String) -> Date? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        if let date = dateFormatter.date(from: dateString) {
//            return Calendar.current.startOfDay(for: date)
//        }
//        return nil
//    }
//}
//
//
///// A square symbol for charts.
//struct Square: ChartSymbolShape, InsettableShape {
//    let inset: CGFloat
//
//    init(inset: CGFloat = 0) {
//        self.inset = inset
//    }
//
//    func path(in rect: CGRect) -> Path {
//        let cornerRadius: CGFloat = 1
//        let minDimension = min(rect.width, rect.height)
//        return Path(
//            roundedRect: .init(x: rect.midX - minDimension / 2, y: rect.midY - minDimension / 2, width: minDimension, height: minDimension),
//            cornerRadius: cornerRadius
//        )
//    }
//
//    func inset(by amount: CGFloat) -> Square {
//        Square(inset: inset + amount)
//    }
//
//    var perceptualUnitRect: CGRect {
//        // The width of the unit rectangle (square). Adjust this to
//        // size the diamond symbol so it perceptually matches with
//        // the circle.
//        let scaleAdjustment: CGFloat = 0.75
//        return CGRect(x: 0.5 - scaleAdjustment / 2, y: 0.5 - scaleAdjustment / 2, width: scaleAdjustment, height: scaleAdjustment)
//    }
//}
//
//
//struct PriceGraphView_Previews: PreviewProvider {
//    static var previews: some View {
//        PriceGraphView()
//    }
//}
