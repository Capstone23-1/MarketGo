//
//  EditStoreReviewView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/06/07.
//
import SwiftUI
import Alamofire

struct EditStoreReviewView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var imageUploader = ImageUploader()
    @State private var imageCate = StoreCategory(categoryID: 7, categoryName: "s_review")
    @State private var newImage = FileInfo()
    @State private var selectedImage: UIImage? = nil
    @State private var isLoading: Bool = false
    
    let storeReviewId: Int
    let storeId: Int
    let viewModel: TestViewModel
    
    @State var ratings: Double = 0.0
    @State var reviewContent: String = ""
    @State var fileId: Int = 113
    
    let starColor = Color(red: 255/255, green: 202/255, blue: 40/255)
    let starWidth: CGFloat = 30.0
    
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Form {
                ReviewImageUploadView(category: $imageCate.categoryName, selectedImage: $selectedImage, newImage: $newImage)
                
                //Text("\(marketReviewId)")
                
                Section(header: Text("상점 리뷰 수정")) {
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
            }
            
            Button(action: {
                Task {
                    await updateStoreReview()
                }
            }) {
                Text("리뷰 수정")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("완료"),
                message: Text("리뷰 수정이 완료되었습니다."),
                dismissButton: .default(Text("확인"), action: {
                    presentationMode.wrappedValue.dismiss()
                    
                })
            )
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        async {
            do {
                let fileInfo = try await ImageDownloader().fetchImageFileInfo(url: "http://3.34.33.15:8080/file/\(fileId)")
                selectedImage = try await ImageDownloader().fetchImage(fileInfo: fileInfo)
            } catch {
                print("Failed to fetch image: \(error)")
            }
        }
    }
    
    func updateStoreReview() async {
        do {
            if let image = self.selectedImage {
                let result = try await imageUploader.uploadImageToServer(image: image, category: imageCate.categoryName, id: String(imageCate.categoryID))
                print("이미지업로드성공:\(String(describing: result.uploadFileName!))")
                
                if let id = result.fileID {
                    fileId = id
                }
            } else {
                fileId = 0
                print("이미지를 선택하지 않았습니다.")
                
            }
        } catch {
            print("Error uploading image: \(error)")
            isLoading = false
            return
        }
        let enreviewContent = makeStringKoreanEncoded(reviewContent)
        let urlString = "http://3.34.33.15:8080/storeReview/\(storeReviewId)?ratings=\(ratings)&reviewContent=\(enreviewContent)&storeReviewFile=\(fileId)"
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(urlString, method: .put, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: StoreReviewElement.self) { response in
                switch response.result {
                case .success(let updatedReview):
                    viewModel.fetchReviews(for: storeId)
                    print("Update successful: \(updatedReview)")
                    showAlert = true
                case .failure(let error):
                    print("업로드 실패! \(error)")
                }
            }
    }
}
