//
//  MarketReviewPostView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/22.
//

import SwiftUI
import Alamofire

struct MarketReviewPostView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var marketModel: MarketModel
    
    var marketID: Int{
        marketModel.currentMarket?.marketID ?? 0
    }
    
    var memberID: Int{
        userModel.currentUser?.memberID ?? 0
    }
//    @State private var marketID: Int = 0
//    @State private var memberID: Int = 61
    
    @State private var ratings: Double = 0.0
    @State private var reviewContent: String = ""
    @State private var marketReviewFile: Int = 1
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    let starColor = Color(red: 255/255, green: 202/255, blue: 40/255)
    let starWidth: CGFloat = 30.0
    
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Review")) {
                    
//                    HStack {
//                        Text("Ratings")
//                        Slider(value: $ratings, in: 0...5, step: 0.5)
//                        Text(String(format: "%.1f", ratings))
//                    }
                    
                    HStack(spacing: 10) {

                        Text("별점")
                        Spacer()
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(ratings) ? "star.fill" : "star")
                                .resizable()
                                .foregroundColor(starColor)
                                .frame(width: starWidth, height: starWidth)
                                .onTapGesture {
                                    ratings = Double(index + 1)
                                }
                        }
                        Spacer()
                        Text(String(format: "%.1f", ratings))
                    }
                    TextEditor(text: $reviewContent)
                        .frame(height: 100)

                }
                
                
                
                Button(action: {
                    submitReview()
                    
                }, label: {
                    Text("Submit")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .disabled(isLoading)
            }
            .navigationBarTitle("Market Review")
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Notification"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
        }
    }
    
    func submitReview() {
        guard marketID != 0 else {
            showAlert(message: "Please enter Market ID.")
            return
        }
        
        guard memberID != 0 else {
            showAlert(message: "Please enter Member ID.")
            return
        }
        
        guard ratings > 0 else {
            showAlert(message: "Please select Ratings.")
            return
        }
        
        guard !reviewContent.isEmpty else {
            showAlert(message: "Please enter Review Content.")
            return
        }

        isLoading = true
        
        let reviewPost = MarketReviewPost(
            marketId: marketID,
            memberId: memberID,
            ratings: ratings,
            reviewContent: reviewContent,
            marketReviewFile: marketReviewFile
        )
        let encoContent = makeStringKoreanEncoded(reviewContent)

        let url = "http://3.34.33.15:8080/marketReview?marketId=\(String(describing:marketID))&memberId=\(String(describing:memberID))&ratings=\(String(describing: ratings))&reviewContent=\(encoContent)&marketReviewFile=\(String(describing: marketReviewFile))"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        AF.request(url, method: .post,headers: headers)
            .responseJSON { response in
                debugPrint(response)
                switch response.result {
                case .success:
                    showAlert(message: "Review submitted successfully.")
                case .failure(let error):
                    showAlert(message: "Failed to submit review. \(error.localizedDescription)")
                }
                isLoading = false
            }
    }

    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
    
}

struct MarketReviewPostView_Previews: PreviewProvider {
    static var previews: some View {
        MarketReviewPostView()
    }
}
