//
//  QuickView.swift
//  MarketGo
//
//  Created by ram on 2023/06/23.
//

import Foundation
import SwiftUI
import Alamofire
import UIKit
struct QuickView: View {
    @StateObject private var vm = PostGoodsViewModel()
    @StateObject public var nvm = NaverViewModel()
    @State private var isShowingImagePicker = false
    @State private var isShowingQuickPostGoodsView = false
    @State private var selectedImage: UIImage?
    @State var stringResult = ""
    
    var body: some View {
        
        ZStack{
            VStack {
                NavigationLink(
                    //                    destination: QuickPostGoodsView(viewModel: vm),
                    destination: QuickPostGoodsView(viewModel: vm),
                    isActive: $isShowingQuickPostGoodsView,
                    label: {
                        EmptyView()
                    }
                )
                
                Button(action: {
                    isShowingImagePicker = true
                }) {
                    Text("가격표를 찍어서 \n빠르게 상품을 등록해보세요")
                        .font(.system(size: 20))
                        .padding()
                        .font(.subheadline)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isShowingImagePicker, onDismiss: {
                    if let selectedImage = selectedImage {
                        
                            nvm.image = selectedImage
                            vm.isLoading = true
                            
                        nvm.changeImageToText { result in
                            DispatchQueue.main.async {
                                if let result = result {
                                    let texts = result.split(separator: " ").map(String.init)
                                    vm.text = result
                                    print("여기는 result")
                                    print(result)
                                    if texts.count > 0 {
                                        vm.goodsName = texts[0]
                                        }
                                        
                                        if texts.count > 1 {
                                            vm.goodsUnit = texts[1]
                                        }
                                        
                                        if texts.count > 2 {
                                            vm.goodsPrice = texts[2]
                                        }
//                                    vm.fetchImageData()
                                    isShowingQuickPostGoodsView = true
                                    vm.isLoading = false
                                } else {
                                    isShowingQuickPostGoodsView = false
                                    vm.isLoading = false
                                }
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
