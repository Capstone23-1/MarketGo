//
//  MarketSearchView.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import SwiftUI
import UIKit


// TODO: 카카오 검색기능으로 찾은 시장이 디비와 일치하지않는경우 에러메시지를 추가해줌
struct MarketSearchView: View {
    @State private var searchText: String = ""
    //드롭다운바 즉,Picker에서 사용하기 위한 사용자가 선택한 옵션을 저장,이 값을 사용하여 리스트를 정렬 1~3까지의 값이 있음,추가될 수 있음
    @State private var sortOption: Int = 0
    //입력필드에서 사용되는 힌트
    
    @State private var placeHolder: String = "가고싶은 시장을 입력하세요"
    @State private var MarketList: [Document] = []
    @State private var errorMessage: String?
    @ObservedObject var locationManager = LocationManager()
    @State private var selectedMarket: Document?
    @State private var isLoading = false // indicator 추가
    var sortedClasses: [Document] {
        switch sortOption {
            case 0: return MarketList.sorted(by: { $0.distance < $1.distance })
                //                case 1: return MarketList.sorted(by: { $0.rating > $1.rating })
            case 2: return MarketList.sorted(by: { $0.placeName < $1.placeName })
            default: return MarketList
        }
    }
    
    var body: some View {
        NavigationView{
            VStack {
                SearchBar(searchText: $searchText,placeHolder: $placeHolder)
                
                HStack{
                    Spacer()
                    Picker(selection: $sortOption, label: Text("정렬 기준")) {
                        Text("거리 가까운 순").tag(0)
                        Text("평점 높은순").tag(1)
                        Text("이름순").tag(2)
                    }
                    .padding(.horizontal)
                    .foregroundColor(.gray)
                }
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                } else {
                    if isLoading {
                        ProgressView()
                            .scaleEffect(3.0)
                            .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                            .padding()
                    } else {
                        
                        MarketMapView(marketList: $MarketList, selectedMarket: $selectedMarket)
                        MarketTableWrapper(data: MarketList, selected: $selectedMarket)
                        
                        
                    }
                    
                }
                NavigationLink(destination: SignInView()){
                    Text("로그인 하기")
                }
                
                
                NavigationLink(destination: MainView()) {
                    Text("화면 넘기기")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10.0)
                }
                
            }
            .onAppear {
                let viewModel = MarketViewModel()
                isLoading = true // 로딩 시작
                viewModel.searchMarket(location: locationManager.userLocation ?? cauLocation, queryKeyword: "시장") { result in
                    switch result {
                        case .success(let parkingLotData):
                            DispatchQueue.main.async {
                                self.MarketList = parkingLotData.documents
                                isLoading = false // 로딩 종료
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.errorMessage = error.localizedDescription
                                isLoading = false // 로딩 종료
                            }
                    }
                }
            }
            
            
        }
        
        
        
    }
}





struct MarketSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MarketSearchView()
    }
}
