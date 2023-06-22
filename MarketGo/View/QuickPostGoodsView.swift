import SwiftUI
import Alamofire
import UIKit

struct QuickPostGoodsView: View {
    @ObservedObject var viewModel:PostGoodsViewModel
    
    @EnvironmentObject var userViewModel: UserModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isImagePickerPresented = false
    @State var isEnroll = false
    var body: some View {
        VStack {
            Form {
                ImageUploadView(category: $viewModel.imageCate.categoryName, selectedImage: $viewModel.selectedImage, newImage: $viewModel.newImage)
                    .padding(.bottom)
                TextField("상품명", text: $viewModel.goodsName)
                TextField("가격", text: $viewModel.goodsPrice)
                TextField("단위", text: $viewModel.goodsUnit)
                TextField("원산지", text: $viewModel.goodsOrigin)
                TextField("물품 설명", text: $viewModel.goodsInfo)
            }
        }
        .onAppear(perform: loadView)
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: alertItem.dismissButton
            )
        }
        .onChange(of: viewModel.alertDismissed) { dismissed in
            if dismissed {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .sheet(isPresented: $isImagePickerPresented, onDismiss: {
            if viewModel.selectedImage != nil {
                print("이미지선택완료")
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            ImagePicker(image: $viewModel.selectedImage)
        }
        
        Button(action: {
            Task{
                isEnroll = true
                await viewModel.postGoods()
            }
        }) {
            Text("등록")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    func loadView() {
        if let storeid = userViewModel.currentUser?.storeID?.storeID {
            viewModel.storeId = storeid
        }
        if let marketid = userViewModel.currentUser?.storeID?.storeMarketID?.marketID {
            viewModel.marketId = marketid
        }
    }
}

