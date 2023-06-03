
import SwiftUI

struct SellerHomeView: View {
    @EnvironmentObject var userModel: UserModel
    @State var storeID:StoreElement?
    @State var isLoading = false
    @State var isLoggingOut = false
    let rad = CGFloat(30)
    var body: some View {
        NavigationView(){
            ScrollView {
                ZStack{
                    VStack() {
                        
                        HStack {
                            if let storeID = storeID {
                                NavigationLink(destination: EditStoreView(obse: ObservableStoreElement(storeElement: storeID))) {
                                    HStack{
                                        
                                        Text("상점\n정보\n수정")
                                            .font(.title)
                                            .fontWeight(.bold)
                                        Image(systemName: "person")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                            .padding(.bottom, 8)
                                    }
                                }
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .frame(height: 200)
                                .background(Color.white)
                                .cornerRadius(rad)
                                .frame(maxWidth: .infinity)
                                .padding(.all,10)
                            }
                            else{
                                
                                NavigationLink(destination: EmptyView()) {
                                    HStack{
                                        
                                        Text("상점\n정보\n수정")
                                            .font(.title)
                                            .fontWeight(.bold)
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            .padding(.bottom, 8)
                                    }
                                }
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .frame(height: 200)
                                .background(Color.white)
                                .cornerRadius(rad)
                                .frame(maxWidth: .infinity)
                                .padding(.all,10)
                                
                            }
                            Button(action: {
                                isLoggingOut = true
                            }) {
                                Text("로그\n아웃")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "escape")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40)
                            }
                            .fullScreenCover(isPresented: $isLoggingOut, content: {
                                SignInView(cart:cart())
                            })
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .frame(height: 200)
                            .background(Color.white)
                            .cornerRadius(rad)
                            .frame(maxWidth: .infinity)
                            .padding(.all,10)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.all,10)
                        
                        HStack {
                            NavigationLink(destination: PostGoodsView()) {
                                Text("상품\n등록")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "doc.text.viewfinder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .frame(height: 200)
                            .background(Color.white)
                            .cornerRadius(rad)
                            .frame(maxWidth: .infinity)
                            .padding(.all,10)
                            NavigationLink(destination: GoodsListSellerView()) {
                                Text("상품 관리")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "list.bullet.rectangle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .frame(height: 200)
                            .background(Color.white)
                            .cornerRadius(rad)
                            .frame(maxWidth: .infinity)
                            .padding(.all,10)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal,10)
                        
                        HStack {
                            
                            
                            NavigationLink(destination: QRCodeView()) {
                                Text("가게\nQR\n생성")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "qrcode.viewfinder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .frame(height: 200)
                            .background(Color.white)
                            .cornerRadius(rad)
                            .frame(maxWidth: .infinity)
                            .padding(.all,10)
                            NavigationLink(destination: DogamQRGenerateView()) {
                                Text("도감\nQR\n생성")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "qrcode.viewfinder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .frame(height: 200)
                            .background(Color.white)
                            .cornerRadius(rad)
                            .frame(maxWidth: .infinity)
                            .padding(.all,10)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal,10)
                    }
                    if isLoading {
                        ProgressView()
                            .scaleEffect(2)
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .frame(width: 100, height: 100)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .onAppear {
                isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    storeID = userModel.currentUser?.storeID
                    isLoading=false
                }
                
            }
        }
    }
}
struct SellerHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SellerHomeView()
            .environmentObject(UserModel()) // 필요한 경우 환경 개체를 추가합니다.
    }
}
