import Foundation
import Alamofire

// MARK: - MartPriceElement
struct MartPriceElement: Codable, Identifiable {
    var martPriceID: Int?
    var goodsName: String?
    var price: Int?
    var source, updateTime: String?

    enum CodingKeys: String, CodingKey {
        case martPriceID = "martPriceId"
        case goodsName, price, source, updateTime
    }
    
    var id: Int? {
        return martPriceID
    }
}

typealias MartPrice = [MartPriceElement]


class MartPriceViewModel: ObservableObject {
    @Published var martPrice: MartPrice = []
    
    func fetchMartPrice(goodsName: String) {
        let letter = makeStringKoreanEncoded(goodsName)
        let urlString = "http://3.34.33.15:8080/martPrice/\(letter)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        AF.request(url).validate().responseDecodable(of: MartPrice.self) { response in
            switch response.result {
            case .success(let martPrice):
                DispatchQueue.main.async {
                    self.martPrice = martPrice
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}


class MartPriceViewModel2: ObservableObject {
    @Published var martPrice: MartPrice = []
    
    func fetchMartPrice() {
        let urlString = "http://3.34.33.15:8080/martPrice/all"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        AF.request(url).validate().responseDecodable(of: MartPrice.self) { response in
            switch response.result {
            case .success(let martPrice):
                DispatchQueue.main.async {
                    self.martPrice = martPrice
                    
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

