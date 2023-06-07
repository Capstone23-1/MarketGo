import SwiftUI

struct UserHomeView: View {
    @EnvironmentObject var userModel: UserModel
    @StateObject private var vm = StoreDogamViewModel()
    var body: some View {
        
        ScrollView {
            VStack() {
                NavigationLink(destination: SeasonView()) {
                    VStack{
                        Text("이번달의 제철 식재료는?")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("사시사철 제철음식을 먹어보아요")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Image(systemName: "carrot.fill")
                        .resizable()
                        .foregroundColor(.orange)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.bottom, 8)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 130)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.bottom, 20)
                
                HStack {
                    
                    NavigationLink(destination: QRCodeReaderView()) {
                        VStack{
                            Image(systemName: "qrcode.viewfinder")
                                .resizable()
                                .foregroundColor(.gray)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding(.bottom, 8)
                            Text("QR로 \n가게정보")
                                .font(.title)
                                .fontWeight(.bold)
                            
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .frame(height: 200)
                    .background(Color.white)
                    .cornerRadius(20)
                    //                        .padding(.bottom, 20)
                    
                    
                    
                    VStack {
                        Button(action:openNaverMap) {
                            Text("길찾기")
                                .font(.title)
                                .fontWeight(.bold)
                            //                            Text("가까운 찾기")
                            //                                .font(.subheadline)
                            //                                .foregroundColor(.secondary)
                            Image(systemName: "bus.fill")
                                .resizable()
                                .foregroundColor(.gray)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                            
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.bottom, 10)
                        
                        
                        
                        NavigationLink(destination: ParkingLotView()) {
                            Text("주차장 찾기")
                                .font(.title)
                                .foregroundColor(.gray)
                                .fontWeight(.bold)
                            //                            Text("가까운 찾기")
                            //                                .font(.subheadline)
                            //                                .foregroundColor(.secondary)
                            Image(systemName: "cursorarrow.rays")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40)
                                .foregroundColor(.gray)
                            
                            
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .background(Color.white)
                        .cornerRadius(20)
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal,10)
                    
                }
                HStack{
                    NavigationLink(destination: CouponView()) {
                        
                        Text("쿠폰 찾기")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.bottom, 10)
                    .padding(.trailing,10)
                    
                    NavigationLink(destination: MarketMapView()) {
                        VStack{
                            Text("시장 지도")
                                .font(.title)
                                .fontWeight(.bold)
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.bottom, 10)
                    .padding(.leading,10)
                }
                .padding(.top)
                .frame(height: 120)
                
                NavigationLink(destination: DogamBookView()) {
                    VStack{
                        Text("마켓고! 도감 모으기")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("10개를 모으면 쿠폰 획득 가능")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Image(systemName: "flag.checkered.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                        .padding(.bottom, 8)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(Color.white)
                .cornerRadius(20)
                
                
                
                
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

struct BannerView: View {
    var body: some View {
        Text("Banner View")
            .font(.title)
            .navigationBarTitle("Banner", displayMode: .inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        UserHomeView()
    }
}
