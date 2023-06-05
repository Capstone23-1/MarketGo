import SwiftUI
import Alamofire
import UIKit


struct PostGoodsView: View {
    @StateObject private var viewModel = PostGoodsViewModel()
    
    @EnvironmentObject var userViewModel: UserModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
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
        .navigationTitle("물품 등록")
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
        
        Button(action: {
            Task {
                await viewModel.postGoods()
            }
        }) {
            Text("Update")
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
        if let marketid = userViewModel.currentUser?.storeID?.storeMarketID!.marketID {
            viewModel.marketId = marketid
        }
        
        
    }
}
