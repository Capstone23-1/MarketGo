//
//  ReviewView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/03.
//

import SwiftUI


struct ReviewView: View {
    @EnvironmentObject var userModel: UserModel
    @Binding var isPresented: Bool
    @State var rating: Int = 0
    @State var reviewContent: String = ""
    @State var selectedImage: UIImage?
    let storeName: String
    @State var orderedItemsText: String = ""
    
    let starColor = Color(red: 255/255, green: 202/255, blue: 40/255)
    let starWidth: CGFloat = 30.0
    
    var body: some View {
        VStack {
            Text("\(userModel.currentUser?.memberID ?? 0)")
            
            Text("만족도 평가 및 리뷰")
                .font(.title2)
                .bold()
                .padding()
            
            HStack(spacing: 10) {
                Text(storeName)
                    .font(.headline)
                    .padding()
                
                ForEach(0..<5) { index in
                    Image(systemName: index < rating ? "star.fill" : "star")
                        .resizable()
                        .foregroundColor(starColor)
                        .frame(width: starWidth, height: starWidth)
                        .onTapGesture {
                            rating = index + 1
                        }
                }
            }
            .padding()
            
            
            VStack(alignment: .leading){
                
                Text("상품 구매 후기")
                    .font(.headline)
                    .padding(.horizontal, 23)
                    .padding(.vertical, 20)
                
                TextEditor(text: $reviewContent)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(Color.gray, lineWidth: 1)
                            .background(Color.white)
                    )
                    .padding(.horizontal, 20)
                
            }
            
          
            Spacer()
            
//            HStack{
//
//                VStack(alignment: .leading){
//
//                    Button(action: {
//                        showImagePicker()
//                    }) {
//                        Image(systemName: "camera.on.rectangle")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 50, height: 50)
//                            .foregroundColor(.black)
//                    }
//
//                    Text("사진추가")
//                }
//                Spacer()
//
//            }.padding(30)
            
            Button(action: {
                saveReview()
            }, label: {
                Text("리뷰 등록")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 1000, height: 20)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 1, y: 2)
            })
            .padding()
            
            Spacer()

        }
        .navigationBarTitle("리뷰 작성")
    }
    
    func showImagePicker() {
        // 사진 선택 처리
    }
    
    func saveReview() {
        
        let marketReview = MarketReview(marketId: 123, memberId: 456, memberName: "John", ratings: Double(rating), reviewContent: reviewContent, marketReviewFile: 0)
        guard let reviewData = try? JSONEncoder().encode(marketReview) else {
            print("Failed to encode review data")
            return
        }
        // reviewData를 서버에 전송하는 로직


        guard let url = URL(string: "http://3.34.33.15:8080/marketReview") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = reviewData

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Failed to send review")
                return
            }

            DispatchQueue.main.async {
                isPresented = false
            }
        }.resume()
    }

    
}


struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(isPresented: Binding.constant(false), storeName: "영찬과일")
    }
}
