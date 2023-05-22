import SwiftUI
import Alamofire

struct TestView: View {
    @State private var marketID: Int = 18
    @State private var memberID: Int = 61
    @State private var ratings: Double = 0.0
    @State private var reviewContent: String = ""
    @State private var marketReviewFile: Int = 106
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    let apiUrl = "http://3.34.33.15:8080/marketReview"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Market Information")) {
                    TextField("Market ID", value: $marketID, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    TextField("Member ID", value: $memberID, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Review")) {
                    HStack {
                        Text("Ratings")
                        Slider(value: $ratings, in: 0...5, step: 0.5)
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
//                switch response.result {
//                case .success:
//                    showAlert(message: "Review submitted successfully.")
//                case .failure(let error):
//                    showAlert(message: "Failed to submit review. \(error.localizedDescription)")
//                }
                isLoading = false
            }
    }

    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
