//
//  SearchViewPractice1.swift
//  SeeJang
//
//  Created by ram on 2023/03/21.
//
/* `SearchView` 만드는 방법
    - UIKit 사용
    - SwiftUI로 간단하게 구현
    - Search View Control 기능 알아보기
 
 */
import SwiftUI


//캔버스 컨텐츠뷰
struct SearchViewPractice1_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewPractice1()
    }
}
 
 
//화면 터치시 키보드 숨김
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct SearchBar: View {
    
    @Binding var text: String

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                //확대경 이미지

                TextField("가고싶은 시장을 입력하세요", text: $text)
                    .foregroundColor(.primary)

                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}

struct SearchViewPractice1: View {
    let array = [
        "쥬디맴", "포뇨", "하울", "소피아", "캐시퍼", "소스케",
        "치히로", "하쿠", "가오나시", "제니바", "카브", "마르클",
        "토토로", "사츠키", "지브리", "스튜디오", "캐릭터"
    ]
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                List {
                    ForEach(array.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                        searchText in Text(searchText)
                    }
                } //리스트의 스타일 수정
                .listStyle(PlainListStyle())
                  //화면 터치시 키보드 숨김 -> SwiftUI에서는 아직 지원x ->UIKit 사용
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .navigationBarTitle("검색기능")
//            .navigationBarItems(trailing:
//                                    HStack{
//                                        Button(action: {
//                                        }) {
//                                            HStack {
//                                                Text("쥬디")
//                                                    .foregroundColor(.black)
//                                                Image(systemName: "folder.fill")
//                                            }
//                                        }
//                                    }
//            )
        }
    }
}

