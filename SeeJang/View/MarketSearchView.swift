//
//  MarketSearchView.swift
//  SeeJang
//
//  Created by ram on 2023/03/23.
//

import SwiftUI
import UIKit



struct MarketSearchView: View {
    @State private var searchText: String = ""
    //드롭다운바 즉,Picker에서 사용하기 위한 사용자가 선택한 옵션을 저장,이 값을 사용하여 리스트를 정렬 1~3까지의 값이 있음 추가될 수 있음
    @State private var sortOption: Int = 0
    //입력필드에서 사용되는 힌트
    @State private var placeHolder: String = "가고싶은 시장을 입력하세요"
    
    
    var seoulMarketList: [MarketInfo] = [
        MarketInfo(marketName: "흑석 시장", rating: 4.3,distance: 0.8),
        MarketInfo(marketName: "상도 시장", rating: 4.9,distance: 1.2),
        MarketInfo(marketName: "광장 시장", rating: 3.3,distance: 7.7)
    ]
    
    var sortedClasses: [MarketInfo] {
        switch sortOption {
            case 0: return seoulMarketList.sorted(by: { $0.marketName < $1.marketName })
            case 1: return seoulMarketList.sorted(by: { $0.rating > $1.rating })
            case 2: return seoulMarketList.sorted(by: { $0.distance > $1.distance })
            case 9: return seoulMarketList.sorted(by: { $0.rating < $1.rating })
            default: return seoulMarketList
        }
    }
    
    
    
    var body: some View {
        NavigationView{
            VStack {
                SearchBar(searchText: $searchText,placeHolder: $placeHolder)
                
                HStack{
                    Spacer()
                    Picker(selection: $sortOption, label: Text("정렬 기준")) {
                        Text("거리 가까운 순").tag(2)
                        Text("평점 높은순").tag(1)
                        Text("이름순").tag(0)
                        //                        Text("Rating Low-High").tag(9)
                    }
                    .padding(.horizontal)
                }
                
                
                List(sortedClasses.filter {
                    searchText.isEmpty ? true : $0.marketName.localizedCaseInsensitiveContains(searchText)
                }, id: \.marketName) { MarketInfo in
                    HStack{
                        Image(systemName:"person.circle")
                            .resizable()
                            .frame(width: 40,height: 40)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                        VStack(alignment: .leading,spacing: 4) {
                            Text("\(MarketInfo.marketName)")
                                .bold()
                                .font(.system(size:20))
                            
                            HStack{
                                Text("\(String(format:"%.1f",MarketInfo.distance)) Km")
                                
                                Spacer()
                                
                                //평점을 나타냄
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow
                                       // .opacity(0.3)
                                    )
                                
                                
                                Text("\(String(format:"%.1f",MarketInfo.rating))")
                            }
                            .font(.system(size:15))
                            
                            
                            
                        }
                        
                        
                        
                    }
                    .listStyle(PlainListStyle())
                    //화면 터치시 키보드 숨김 -> SwiftUI에서는 아직 지원x ->UIKit 사용
                    .onTapGesture {
                        hideKeyboard()
                    }
                    
                    
                }
                
                
            }
            .navigationBarTitle("시장 찾기",displayMode: .automatic)
            .font(.title3)
           // .navigationBarTitleDisplayMode(.inline)
            //위에 패딩이 너무 많은 거 같아서 바꾸고 싶다.
            
        }
        
        
    }
    
    
}


struct MarketSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MarketSearchView()
    }
}
