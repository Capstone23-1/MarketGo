//
//  ContentView.swift
//  SeeJang
//
//  Created by ram on 2023/03/23.
//

import SwiftUI
import UIKit

//화면 터치시 키보드 숨김
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


public struct MarketInfo {
    var marketName: String
    var rating: Float
    var distance: Float //단위 km
}
struct ContentView: View {
    @State private var searchText: String = ""
    @State private var sortOption: Int = 0
    
    
    var classes: [MarketInfo] = [
        MarketInfo(marketName: "흑석시장", rating: 4.3,distance: 0.8),
        MarketInfo(marketName: "상도시장", rating: 4.9,distance: 1.2),
        MarketInfo(marketName: "광장시장", rating: 3.3,distance: 7.7)
    ]
    
    var sortedClasses: [MarketInfo] {
        switch sortOption {
        case 0: return classes.sorted(by: { $0.marketName < $1.marketName })
        case 1: return classes.sorted(by: { $0.rating > $1.rating })
        case 2: return classes.sorted(by: { $0.distance > $1.distance })
        case 9: return classes.sorted(by: { $0.rating < $1.rating })
        default: return classes
        }
    }
    
    var body: some View {
        NavigationView{
            VStack {
                HStack{ // SearchBar(Title:검색기능)
                    
                    Image(systemName: "magnifyingglass")
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    TextField("가고싶은 시장을 입력하세요", text: $searchText)
                        .foregroundColor(.primary)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        
                }
                
                
                HStack{
                    Spacer()
                    Picker(selection: $sortOption, label: Text("정렬 기준")) {
                        Text("거리순").tag(2)
                        Text("평정 높은순").tag(1)
                        Text("이름순").tag(0)
                        Text("Rating Low-High").tag(9)
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
                            
                            HStack{
                                Text("\(String(format:"%.1f",MarketInfo.distance)) Km")
                                Spacer()
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.gray.opacity(0.3))
                                
                                
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
            
        }
            
        }
        
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
