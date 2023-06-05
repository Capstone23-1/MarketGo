import SwiftUI
import Alamofire
import UIKit

struct QuickPostGoodsView: View {
    @ObservedObject var viewModel:PostGoodsViewModel
    
    @EnvironmentObject var userViewModel: UserModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isImagePickerPresented = false
    
    var body: some View {
        VStack {
            Form {
                ImageUploadView(category: $viewModel.imageCate.categoryName, selectedImage: $viewModel.selectedImage, newImage: $viewModel.newImage)
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
        .sheet(isPresented: $isImagePickerPresented, onDismiss: {
            if viewModel.selectedImage != nil {
                print("이미지선택완료")
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            ImagePicker(image: $viewModel.selectedImage)
        }
        
        Button(action: {
            isImagePickerPresented = true
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
        if let marketid = userViewModel.currentUser?.storeID?.storeMarketID?.marketID {
            viewModel.marketId = marketid
        }
    }
}
struct QuickView: View {
    @StateObject private var vm = PostGoodsViewModel()
    @State private var isShowingImagePicker = false
    @State private var isShowingQuickPostGoodsView = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        
        ZStack{
            VStack {
                NavigationLink(
                    destination: QuickPostGoodsView(viewModel: vm),
                    isActive: $isShowingQuickPostGoodsView,
                    label: {
                        EmptyView()
                    }
                )
                
                Button(action: {
                    isShowingImagePicker = true
                }) {
                    Text("오늘의 가판대를 찍어서 빠르게 상품을 등록해주세요")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isShowingImagePicker, onDismiss: {
                    if selectedImage != nil {
                        vm.isLoading = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            
                            Task{
                                if let image = selectedImage?.size.width, image == 275.0 {
                                                               vm.text = "1"
                                                           } else {
                                                               vm.text = "2"
                                                              
                                                           }
                                print("size",selectedImage?.size)
//                                print("scale",selectedImage?.scale)
                                vm.fetchImageData()
                                
                                isShowingQuickPostGoodsView = true
                                vm.isLoading = false
                            }
                             
                            
                        }
                    }
                }) {
                    ImagePicker(image: $selectedImage)
                }
                
            }
            if vm.isLoading {
                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .frame(width: 100, height: 100)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    .shadow(radius: 10)
            }
        }
        .navigationTitle("빠른 상품 등록")
        
    }
}
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let nerModel = try? JSONDecoder().decode(NerModel.self, from: jsonData)

import Foundation

// MARK: - NerModel
struct NerModel: Codable {
    var id: Int?
    var imageName, text1, text2, text3: String?
}
