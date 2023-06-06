//
//  MarketReviewPutView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/06/07.
//
import SwiftUI
import Alamofire

struct MarketReviewPutView: View {
    let marketReviewId: Int
    @State var ratings: Double = 0.0
    @State var reviewContent: String = ""
    @State var marketReviewFile: Int = 113
    
    var body: some View {
        VStack {
            Text("\(marketReviewId)")
            TextField("Ratings", value: $ratings, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Review Content", text: $reviewContent)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
//            TextField("Market Review File", text: $marketReviewFile)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
            
            Button(action: {
                updateMarketReview()
            }, label: {
                Text("리뷰 수정")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(30)
            })
            .padding()
        }
    }
    
    
    func updateMarketReview() {
        let urlString = "http://3.34.33.15:8080/marketReview/\(marketReviewId)"
        let parameters: [String: Any] = [
            "ratings": ratings,
            "reviewContent": reviewContent,
            "marketReviewFile": marketReviewFile
        ]
        
        AF.request(urlString, method: .put, parameters: parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success:
                print("Market review updated successfully.")
            case .failure(let error):
                print("Error updating market review: \(error)")
            }
        }
    }
}
