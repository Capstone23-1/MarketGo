//
//  SignInView.swift
//  MarketGo
//
//  Created by ram on 2023/05/10.
//
import SwiftUI
// TODO: 로그인 성공시 현위치를 받음
struct SignInView: View {
    @State private var selectedTab = 0
    @State private var moveToProfileView = false
    // SignInViewModel을 StateObject로 선언하여 로그인 상태를 관리합니다.
    @StateObject private var viewModel = UserSignInViewModel()
    // 회원가입 창을 표시할지 여부를 결정하는 State 변수
    @State private var showSignUpView = false
    // 로그인 성공 시 MarketSearchView로 전환할지 여부를 결정하는 State 변수
    @State private var moveToMarketSearchView = false
    // 메인화면 바로가기 버튼 클릭 시 MarketSearchView로 전환할지 여부를 결정하는 State 변수
    @State private var moveToMarketSearchViewDirectly = false
    // 소비자와 상인 중 선택된 항목을 저장하는 State 변수
    @State private var selectedRole = 0
    // 소비자와 상인을 선택할 수 있는 Picker에 사용할 데이터
    @State var tempUser: MemberInfo?
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    VStack(spacing: 20) {
                        // 소비자와 상인을 선택할 수 있는 Picker
                        Picker(selection: $selectedTab, label: Text("탭")) {
                            Text("소비자").tag(0)
                            Text("상인").tag(1)
                            
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        switch selectedTab {
                            case 0:
                                UserSignInView(moveToProfileView: $moveToProfileView, showSignUpView: $showSignUpView)
                            case 1:
                                SellerSignInView(moveToProfileView: $moveToProfileView, showSignUpView: $showSignUpView)
//                                UserSignInView(moveToProfileView: $moveToProfileView, showSignUpView: $showSignUpView)
                            default:
                                Text("잘못된 선택")
                        }
                        
                     
                        
                        // 메인화면 바로가기 버튼
                        Button(action: {
                            // 버튼 클릭 시 moveToMarketSearchViewDirectly 상태를 true로 변경하여 MarketSearchView로 전환
                            self.moveToMarketSearchViewDirectly = true
                        }) {
                            Text("메인화면 바로가기")
                                .foregroundColor(.blue)
                        }
                        .fullScreenCover(isPresented: $moveToMarketSearchViewDirectly) {
                            MarketSearchView()
                        }
                        NavigationLink(destination:EditProfileView()){
                            Text("회원정보수정")
                        }
                        
                        
                    }
                    .padding()
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}
