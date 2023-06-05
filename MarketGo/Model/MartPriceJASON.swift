// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let martPrice = try? JSONDecoder().decode(MartPrice.self, from: jsonData)

import Foundation

// MARK: - MartPriceElement
struct MartPriceElement: Codable {
    var martPriceID: Int?
    var goodsName: String?
    var price: Int?
    var source, updateTime: String?

    enum CodingKeys: String, CodingKey {
        case martPriceID = "martPriceId"
        case goodsName, price, source, updateTime
    }
}

typealias MartPrice = [MartPriceElement]

func fetchMartPrice(goodsName: String) {
    let urlString = "http://3.34.33.15:8080/martPrice/\(goodsName)"
    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return
    }

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
            return
        }

        guard let data = data else {
            print("Data not found")
            return
        }

        do {
            let decoder = JSONDecoder()
            let martPrice = try decoder.decode(MartPrice.self, from: data)
            // Process the fetched martPrice data
            print(martPrice)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }

    task.resume()
}
