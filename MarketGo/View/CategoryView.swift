////
////  CategoryView.swift
////  MarketGo
////
////  Created by 김주현 on 2023/05/12.
////
//
//import SwiftUI
//import Alamofire
//
//struct CategoryElement: Codable {
//    var categoryID: Int?
//    var categoryName: String?
//
//    enum CodingKeys: String, CodingKey {
//        case categoryID = "categoryId"
//        case categoryName
//    }
//}
//
//typealias Category = [CategoryElement]
//
//class CategoryViewModel: ObservableObject {
//    @Published var categories: Category = []
//    
//    func fetchCategories() {
//        let url = "http://3.34.33.15:8080/category/all"
//        
//        AF.request(url).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    let decoder = JSONDecoder()
//                    let categories = try decoder.decode(Category.self, from: data)
//                    DispatchQueue.main.async {
//                        self.categories = categories
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
//
//struct CategoryView: View {
//    @ObservedObject var viewModel = CategoryViewModel()
//    
//    var body: some View {
//        List(viewModel.categories, id: \.categoryID) { category in
//            Text(category.categoryName ?? "")
//        }
//        .onAppear {
//            viewModel.fetchCategories()
//        }
//    }
//}
//
//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}
