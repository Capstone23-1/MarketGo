//
//  ReviewView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/03.
//

import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


struct ReviewView: View {
    @Binding var isPresented: Bool
    @State var rating: Int = 0
    @State var reviewText: String = ""
    @State var selectedImage: UIImage?
    let storeName: String
    @State var orderedItemsText: String = ""
    
    let starColor = Color(red: 255/255, green: 202/255, blue: 40/255)
    let starWidth: CGFloat = 30.0
    
    var body: some View {
        VStack {
            Text("만족도 평가 및 리뷰")
                .font(.title)
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
            
            VStack(alignment: .leading) {
                            Text("구매한 물품")
                                .font(.headline)
                                .padding(20)
                            
                            TextEditor(text: $orderedItemsText)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 2)
                                        .stroke(Color.gray, lineWidth: 1)
                                        .background(Color.white)
                                )
                                .frame(height: 50)
                                .padding(.horizontal, 20)
                        }

            
//
//            if let image = selectedImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 200, height: 200)
//                    .padding()
//            }
            
            VStack(alignment: .leading){
                
                Text("구매 후기")
                    .font(.headline)
                    .padding(20)
                
                TextEditor(text: $reviewText)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(Color.gray, lineWidth: 1)
                            .background(Color.white)
                    )
                    .padding(.horizontal, 20)
                
            }
            
          
            Spacer()
            
            HStack{
                
                VStack(alignment: .leading){
            
                    Button(action: {
                        showImagePicker()
                    }) {
                        Image(systemName: "camera.on.rectangle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.black)
                    }
                    
                    Text("사진추가")
                }
                Spacer()
                
            }.padding(30)
            
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
        //        let newReview = Review(rating: rating, text: reviewText, image: selectedImage, storeName: storeName, orderedItems: orderedItems)
        //        StorageManager.shared.saveReview(newReview) // 저장소에 리뷰 저장
        //        isPresented = false // 리뷰 작성 창 닫기
    }
    
}


struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(isPresented: Binding.constant(false), storeName: "영찬과일")
    }
}
