
import SwiftUI
import SwiftUI

struct SellerHomeView: View {
    @EnvironmentObject var userModel: UserModel
    var body: some View {
        
        ScrollView {
            VStack() {
                
                HStack {
                    
                    NavigationLink(destination: EditStoreView(obse: ObservableStoreElement(storeElement: (userModel.currentUser?.storeID)!))) {
                        VStack{
                            Image(systemName: "")
                                .resizable()
                                .foregroundColor(.gray)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding(.bottom, 8)
                            Text("상품 등록 창")
                                .font(.title)
                                .fontWeight(.bold)

                      
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .frame(height: 200)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    
                    
                    
                    VStack {
                       NavigationLink(destination: PostGoodsView()) {
                            Text("상품 등록창")
                                .font(.title)
                                .fontWeight(.bold)
                            Image(systemName: "cursorarrow.rays")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40)
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .background(Color.white)
                        .cornerRadius(20)
                        NavigationLink(destination: GoodsListSellerView()) {
                            Text("상품 리스트")
                                .font(.title)
                                .fontWeight(.bold)
                            Image(systemName: "cursorarrow.rays")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40)
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .background(Color.white)
                        .cornerRadius(20)

                        
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal,10)
                    
                }
                NavigationLink(destination: BannerView()) {
                    VStack{
                        Text("마켓고! 도감 모으기")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("10개를 모으면 쿠폰 획득 가능")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Image(systemName: "point.3.connected.trianglepath.dotted")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.bottom, 8)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.top, 20)
                NavigationLink(destination: CouponBookView()) {
                    VStack{
                        Text("쿠폰 찾기")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Image(systemName: "flag.checkered.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.bottom, 8)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.top, 20)
                
                
            }
            
            .padding()
        }.background(Color.gray.opacity(0.2))
    }
    func openNaverMap() {
        if let selectedMarketName = userModel.currentUser?.interestMarket?.marketName{
            let name = makeStringKoreanEncoded(selectedMarketName)
            let encodedBundleID = makeStringKoreanEncoded(Config().bundleID)
            
            if let naverURL = URL(string: "nmap://place?lat=\(userModel.currentUser?.interestMarket?.marketLatitude ?? cauLocation.lat)&lng=\(userModel.currentUser?.interestMarket?.marketLongitude ?? cauLocation.lng)&name=\(name)&appname=\(encodedBundleID)") {
                if UIApplication.shared.canOpenURL(naverURL) {
                    UIApplication.shared.open(naverURL)
                } else {
                    
//                    let webURL = URL(string: "https://map.naver.com/v5/search?query=\(name)")
//                    UIApplication.shared.open(webURL!)
                    let webURL = URL(string: "https://map.naver.com/v5/search?query=\(name)")
                    UIApplication.shared.open(webURL!)
                }
            }
        } else {
            print("Error: Missing name or bundleID")
        }
        
        
    }
}

struct SellerTempView: View {
    @EnvironmentObject var userViewModel: UserModel
    @EnvironmentObject var marketModel: MarketModel
    @State var move1 = false
    @State var move2 = false
    @State var move3 = false
    @State var move4 = false
    @State var move5 = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    move1 = true
                } label: {
                    Text("정보수정창")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $move1) {
                    if let storeElement = userViewModel.currentUser?.storeID {
                        EditStoreView(obse: ObservableStoreElement(storeElement: storeElement))
                    } else {
                        // Provide a view for when storeElement is nil
                        Text("No store data available")
                    }
                }
                
                Button {
                    move2 = true
                } label: {
                    Text("상품 등록 창")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $move2) {
                    PostGoodsView()
                }
                
                Button {
                    move3 = true
                } label: {
                    Text("상품 리스트 창")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $move3) {
                    GoodsListSellerView()
                }
                NavigationLink(destination: DogamQRGenerateView()) {
                    Text("도감 QR 생성")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                NavigationLink(destination: QRCodeReaderView()) {
                    Text("QR 인식")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                }
            }
        }
    }
}
