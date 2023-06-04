import SwiftUI
import Alamofire

struct StoreReviewPostView: View {
    let store: StoreElement
    
    @State private var selectedImage: UIImage? = nil
    @State private var imageCate = StoreCategory(categoryID: 5, categoryName: "s_review")
    @State private var imageUploader = ImageUploader()
    @State private var newImage = FileInfo()
    
    @EnvironmentObject private var storePost: StorePostViewModel
    @EnvironmentObject var userModel: UserModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var ratings: Double = 0.0
    @State private var reviewContent: String = ""
    @State private var storeReviewFile: Int = 1
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var storeID: Int{
          store.storeID ?? 0
      }
      
      var memberID: Int{
          userModel.currentUser?.memberID ?? 0
      }

    
    let starColor = Color(red: 255/255, green: 202/255, blue: 40/255)
    let starWidth: CGFloat = 27.0
    
    @State private var reviewSubmitted: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                ReviewImageUploadView(category: $imageCate.categoryName, selectedImage: $selectedImage, newImage: $newImage)
                
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
                
                Button(action: {
                    Task {
                        await submitReview()
                    }
                }) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(isLoading)
            }
            .navigationBarTitle("\(store.storeName ?? "") Review")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Notification"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                    if reviewSubmitted {
                        navigateToReviewList()
                    }
                })
            }
            .background(
                NavigationLink(destination: StoreReviewListView(store: store), isActive: $reviewSubmitted) {
                    EmptyView()
                }
            )
        }
    }
    
    // Submit the review
    func submitReview() async {
        // Validation checks
        guard storeID != 0 else {
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
            showAlert(message: "리뷰를 작성해주세요.")
            return
        }
        
        isLoading = true
        
        do {
            if let image = self.selectedImage {
                let result = try await imageUploader.uploadImageToServer(image: image, category: imageCate.categoryName, id: String(imageCate.categoryID))
                
                print("이미지업로드성공:\(String(describing: result.uploadFileName!))")
                
                if let id = result.fileID {
                    self.newImage = result
                    print("file id get : \(newImage.fileID) id: \(id)")
                    storeReviewFile = id
                }
            } else {
                print("이미지를 선택하지 않았습니다.")
                return
            }
            
            let reviewPost = StoreReviewPost(
                storeId: storeID,
                memberId: memberID,
                ratings: ratings,
                reviewContent: reviewContent,
                storeReviewFile: storeReviewFile
            )
            let encoContent = makeStringKoreanEncoded(reviewContent)
            
            let url = "http://3.34.33.15:8080/storeReview?storeId=\(String(describing:storeID))&memberId=\(String(describing:memberID))&ratings=\(String(describing: ratings))&reviewContent=\(encoContent)&storeReviewFile=\(String(describing: storeReviewFile))"
            let headers: HTTPHeaders = ["Content-Type": "application/json"]
            AF.request(url, method: .post, headers: headers)
                .responseJSON { response in
                    debugPrint(response)
                    switch response.result {
                    case .success:
                        showAlert(message: "리뷰 작성이 완료되었습니다.")
                        reviewSubmitted = true
                        
                    case .failure(let error):
                        showAlert(message: "리뷰 작성 실패 \(error.localizedDescription)")
                    }
                    isLoading = false
                }
        } catch {
            print("Error uploading image: \(error)")
        }
    }
    
    // Show the alert with the given message
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
    
    // Navigate to the StoreReviewListView
    func navigateToReviewList() {
        reviewSubmitted = false
        presentationMode.wrappedValue.dismiss()
    }

}
