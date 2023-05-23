import SwiftUI
import Alamofire
struct EditGoodsView: View {
    @ObservedObject var viewModel: EditGoodsViewModel

    @EnvironmentObject var userViewModel: UserModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
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
        }
        .navigationTitle("물품 수정")
        Button(action: {
            Task {
                print(self.viewModel.isAvail)
                await viewModel.updateGoods(isAvail: $viewModel.isAvail)
                print(self.viewModel.isAvail)
            }
        }) {
            Text("Update")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
