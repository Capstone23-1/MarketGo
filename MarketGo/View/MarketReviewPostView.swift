//
//  MarketReviewPostView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/22.
//

import SwiftUI
import Alamofire

struct MarketReviewPostView: View {
    @State private var selectedImage: UIImage? = nil // 선택된 이미지를 저장할 변수
    @State private var imageCate = StoreCategory(categoryID: 4,categoryName: "m_review")
    @State private var imageUploader = ImageUploader()
    @State private var newImage = FileInfo()
    
    @EnvironmentObject private var storePost: StorePostViewModel
    
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var marketModel: MarketModel
    @Environment(\.presentationMode) var presentationMode

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
                
                ReviewImageUploadView(category: $imageCate.categoryName,  selectedImage: $selectedImage, newImage: $newImage)
                
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
                    Task{
                        await submitReview()
                    }
                    
                    
                }, label: {
                    Text("작성 완료")
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
    
    func submitReview() async {
        guard marketID != 0 else {
            showAlert(message: "Please enter Market ID.")
            return
        }
        
        guard memberID != 0 else {
            showAlert(message: "Please enter Member ID.")
            return
        }
        
        guard ratings >= 0 else {
            showAlert(message: "Please select Ratings.")
            return
        }
        
        guard !reviewContent.isEmpty else {
            showAlert(message: "Please enter Review Content.")
            return
        }
        
        isLoading = true
        
        do {
            if let image = self.selectedImage {
                let result = try await imageUploader.uploadImageToServer(image: image, category: imageCate.categoryName, id: String(imageCate.categoryID))
                
                print("이미지업로드성공:\(String(describing: result.uploadFileName!))")
                
                if let id = result.fileID {
                    self.newImage = result // Update the newImage property
                    print("file id get : \(newImage.fileID) id: \(id)")
                    marketReviewFile = id // Update the marketReviewFile property
                }
            } else {
                print("이미지를 선택하지 않았습니다.")
                return
            }
            
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
            AF.request(url, method: .post, headers: headers)
                .responseJSON { response in
                    debugPrint(response)
                    switch response.result {
                    case .success:
                        showAlert(message: "리뷰 작성이 완료되었습니다.")
                    case .failure(let error):
                        showAlert(message: "리뷰 작성 실패 \(error.localizedDescription)")
                    }
                    isLoading = false
                }
        } catch {
            print("Error uploading image: \(error)")
        }
    }


    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
        presentationMode.wrappedValue.dismiss()
    }
    
}
