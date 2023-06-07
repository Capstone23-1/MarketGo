//
//  MarketReviewPutView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/06/07.
//
import SwiftUI
import Alamofire

struct MarketReviewPutView: View {
    @State private var imageUploader = ImageUploader()
    @State private var imageCate = StoreCategory(categoryID: 6,categoryName: "m_review")
    @State private var newImage = FileInfo()
    @State private var selectedImage: UIImage? = nil
    @State private var isLoading: Bool = false
    
    let marketReviewId: Int
    @State var ratings: Double = 0.0
    @State var reviewContent: String = ""
    @State var fileId: Int = 113
    
    let starColor = Color(red: 255/255, green: 202/255, blue: 40/255)
    let starWidth: CGFloat = 30.0
    
    var body: some View {
        VStack {
            Form {
                
                ReviewImageUploadView(category: $imageCate.categoryName,  selectedImage: $selectedImage, newImage: $newImage)
                
                Text("\(marketReviewId)")
                
                Section(header: Text("Review")) {
                    
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
                
            }.onAppear(perform: loadData)
            
            Button(action: {
                Task {
                    await updateMarketReview()
                }
            }) {
                Text("리뷰 수정")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    func loadData() {

        async {
            do {
                let fileInfo = try await ImageDownloader().fetchImageFileInfo(url: "http://3.34.33.15:8080/file/\(fileId)")
                selectedImage = try await ImageDownloader().fetchImage(fileInfo: fileInfo)
                // 사용하려는 이미지가 여기에 있습니다.
            } catch {
                // 오류 처리
                print("Failed to fetch image: \(error)")
            }
        }

    }
    
    func updateMarketReview() async {
        do {
            if let image = self.selectedImage {
                let result = try await imageUploader.uploadImageToServer(image: image, category: imageCate.categoryName, id: String(imageCate.categoryID))
                print("이미지업로드성공:\(String(describing: result.uploadFileName!))")
                
                if let id = result.fileID {
                    fileId = id
                    
                }
            } else {
                print("이미지를 선택하지 않았습니다.")
                return
            }
        }
            catch {
                print("Error uploading image: \(error)")
                isLoading = false
            }
        
        
        let enreviewContent = makeStringKoreanEncoded(reviewContent)
        let enfileId = String(describing: fileId)
        //http://3.34.33.15:8080/marketReview/86?ratings=4.0&reviewContent=ㅍㅣㅣ고ㄴ하다&marketReviewFile=311

        let urlString = "http://3.34.33.15:8080/marketReview/\(marketReviewId)?ratings=\(ratings)&reviewContent=\(enreviewContent)&marketReviewFile=\(fileId)"
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        
        AF.request(urlString, method: .put, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MarketReviewElement.self) {response in
                switch response.result {
                    case .success(let updatedReview):
                        print("Update successful: \(updatedReview)")
                    case .failure(let error):
                        print("업로드 실패! \(error)")
                }
            }
        
    }
    
    
//    func updateMarketReview(Id: Int) {
//        let urlString = "http://3.34.33.15:8080/marketReview/\(Id)"
//        let parameters: [String: Any] = [
//            "ratings": ratings,
//            "reviewContent": reviewContent,
//            "marketReviewFile": marketReviewFile
//        ]
//
//        AF.request(urlString, method: .put, parameters: parameters, encoding: JSONEncoding.default).response { response in
//            switch response.result {
//            case .success:
//                print("Market review updated successfully.")
//            case .failure(let error):
//                print("Error updating market review: \(error)")
//            }
//        }
//    }
    
    
}
