import SwiftUI
import Alamofire
struct EditGoodsView: View {
    @ObservedObject var viewModel: EditGoodsViewModel
    @State var isLoading = false
    @EnvironmentObject var userViewModel: UserModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack{
            VStack {
                Form {
                    ImageUploadView(category: $viewModel.imageCate.categoryName, selectedImage: $viewModel.selectedImage, newImage: $viewModel.newImage)
                    TextField("상품명", text: $viewModel.goodsName)
                    TextField("가격", text: $viewModel.goodsPrice)
                    TextField("단위", text: $viewModel.goodsUnit)
                    TextField("원산지", text: $viewModel.goodsOrigin)
                    TextField("물품 설명", text: $viewModel.goodsInfo)
                    Toggle(isOn: Binding(get: {
                        self.viewModel.isAvail != 0
                    }, set: { newValue in
                        self.viewModel.isAvail = newValue ? 1 : 0
                        self.viewModel.goods.isAvail = self.viewModel.isAvail
                        print(self.viewModel.isAvail)
                    })) {
                        Text("게시여부")
                    }
                }
                Button(action: {
                    isLoading = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        
                        Task{
                            await viewModel.updateGoods(isAvail: $viewModel.isAvail)
                        }
                         
                        
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isLoading = true
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                }) {
                    Text("수정")
                        .padding()
                        .frame(minWidth: 35)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            if isLoading {
                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .frame(width: 100, height: 100)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    .shadow(radius: 10)
            }
            
            
        }
        .navigationTitle("물품 수정")
        
    }
}
