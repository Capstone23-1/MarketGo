//
//  ReviewStore.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/03.
//

import Foundation

struct MarketReview: Codable, Identifiable {
    var id = UUID()
    var marketId: Int
    var memberId: Int
    var memberName: String
    var ratings: Double
    var reviewContent: String
    var marketReviewFile: Int
    
    enum CodingKeys: String, CodingKey {
         case marketId, memberId, memberName, ratings, reviewContent, marketReviewFile
     }
}



struct Review: Identifiable, Codable{
    var id = UUID()
    let author: String
    let storeId: Int
    let rating: Int
    let text: String
    //var image: UIImage?
    let imageName: String? // 이미지 파일 이름 추가
    
}

extension Review{
    
    static let reviews :[Review] = [
        Review(author: "김흑석", storeId: 1, rating: 4, text: "음식도 신선하고 서비스도 좋아요!", imageName: "review1" ),
        Review(author: "김푸앙", storeId: 1, rating: 5, text: "음식과 서비스 모두 훌륭합니다!",imageName: "review2"),
        Review(author: "흑석솜주먹", storeId: 1, rating: 3, text: "물건 자체는 괜찮았지만 가격이 조금 비싸요.",imageName: "review3"),
        Review(author: "양재주현", storeId: 1, rating: 2, text: "그냥 그랬어요.",imageName: nil),
        Review(author: "중대생", storeId: 1, rating: 4, text: "상품 다양성이 좋았습니다. 추천합니다.",imageName: nil)
    ]
    
}


class ReviewStore {
    static let shared = ReviewStore()
    
    private let userDefaults = UserDefaults.standard
    private let reviewsKey = "reviews"
    
    func addReview(review: Review) {
        var reviews = getReviews()
        reviews.append(review)
        saveReviews(reviews: reviews)
    }
    
    func getReviews() -> [Review] {
        guard let reviewData = userDefaults.data(forKey: reviewsKey) else {
            return []
        }
        
        let decoder = JSONDecoder()
        do {
            let reviews = try decoder.decode([Review].self, from: reviewData)
            return reviews
        } catch {
            print("Error decoding reviews: \(error.localizedDescription)")
            return []
        }
    }
    
    private func saveReviews(reviews: [Review]) {
        let encoder = JSONEncoder()
        do {
            let reviewData = try encoder.encode(reviews)
            userDefaults.set(reviewData, forKey: reviewsKey)
        } catch {
            print("Error encoding reviews: \(error.localizedDescription)")
        }
    }
    
    func deleteReview(at indexSet: IndexSet) {
        var reviews = getReviews()
        reviews.remove(atOffsets: indexSet)
        saveReviews(reviews: reviews)
    }
    
    func updateReview(_ review: Review, atIndex index: Int) {
        var reviews = getReviews()
        reviews[index] = review
        saveReviews(reviews: reviews)
    }
}

        
        

