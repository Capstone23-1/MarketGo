////
////  StoreReviewListView.swift
////  MarketGo
////
////  Created by 김주현 on 2023/05/04.
////
//
//import SwiftUI
//
//struct StoreReviewListView: View {

//    let store: Store
//    @State private var reviews: [Review] = Review.reviews
//    @State private var showMoreReviews = false
//    
//    @ObservedObject var storeModel = StoreViewModel()
//    

//    var body: some View {
//        VStack() {
//            Text("\(store.store_name) Review")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding()
//            
//            ScrollView {
//                LazyVStack() {
//                    ForEach(reviews) { review in
//                        ReviewRow(review: review)
//                    }
//                }
//            }
//            .padding()
//            
//            
//        }
//    }
//    
//}
//
//struct ReviewRow: View {
//    let review: Review
//    @State private var image: UIImage? = nil
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack(alignment: .top) {
//                Text("\(review.rating)점")
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 5)
//                    .padding(.vertical, 5)
//                    .background(Color.yellow)
//                    .cornerRadius(10)
//                
//                HStack(spacing: 0) {
//                                    ForEach(0..<5) { index in
//                                        Image(systemName: "star.fill")
//                                            .foregroundColor(index < review.rating ? .yellow : .gray)
//                                    }
//                }.padding(.leading,5)
//                               
//                Text(review.author)
//                    .font(.headline)
//                    .fontWeight(.bold)
//                
//            }
//            
//            Text(review.text)
//                .font(.body)
//                .padding(.horizontal, 1)
//                .padding(.vertical, 7)
//            
//            if let imageName = review.imageName {
//                Image(imageName)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(maxWidth: .infinity, maxHeight:200)
//                    .padding(.horizontal, 1)
//                    .padding(.vertical, 3)
//            }
//          
//
//        }
//        .padding()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.white)
//        .cornerRadius(5)
//        .shadow(radius: 2, y: 1)
//
//
//    }
//}
//
//
//struct StoreReviewListView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        StoreReviewListView()
//    }
//}
