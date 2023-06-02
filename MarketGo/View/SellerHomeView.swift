
import SwiftUI

struct SellerHomeView: View {
    @EnvironmentObject var userModel: UserModel
    @State var storeID:StoreElement?
    @State var isLoading = false
    let rad = CGFloat(30)
    var body: some View {
        NavigationView(){
            ScrollView {
                ZStack{
                    VStack() {
                        
                        HStack {
                            if let storeID = storeID {
                                NavigationLink(destination: EditStoreView(obse: ObservableStoreElement(storeElement: storeID))) {
                                    VStack{
                                        Image(systemName: "")
                                            .resizable()
                                            .foregroundColor(.gray)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            .padding(.bottom, 8)
                                        Text("회원정보수정창")
                                            .font(.title)
                                            .fontWeight(.bold)
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
                                    VStack{
                                        Image(systemName: "")
                                            .resizable()
                                            .foregroundColor(.gray)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            .padding(.bottom, 8)
                                        Text("회원정보수정창")
                                            .font(.title)
                                            .fontWeight(.bold)
                                    }
                                }
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .frame(height: 200)
                                .background(Color.white)
                                .cornerRadius(rad)
                                .frame(maxWidth: .infinity)
                                .padding(.all,10)
                                
                            }
                            NavigationLink(destination: PostGoodsView()) {
                                Text("상품\n등록창")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "cursorarrow.rays")
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
                        .padding(.all,10)
                        
                        HStack {
                            NavigationLink(destination: PostGoodsView()) {
                                Text("상품\n등록창")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "cursorarrow.rays")
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
                                Text("상품 리스트 창")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "cursorarrow.rays")
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
                            
                            NavigationLink(destination: DogamQRGenerateView()) {
                                Text("도감\nQR\n생성")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "cursorarrow.rays")
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
                            NavigationLink(destination: QRCodeView()) {
                                Text("가게\n안내\nQR")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "cursorarrow.rays")
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
