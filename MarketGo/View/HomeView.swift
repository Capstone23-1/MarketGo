import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    NavigationLink(destination: BannerView()) {
                        Text("배너")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("가까운 찾기")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Image(systemName: "qrcode.viewfinder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 8)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                        BannerItemView()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                        
                        VStack {
                            BannerItemView()
                                .frame(maxHeight: 100)
                            BannerItemView()
                                .frame(maxHeight: 100)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .padding()
            }
            
        }
    }
}

struct BannerItemView: View {
    var body: some View {
        NavigationLink(destination: BannerView()) {
            VStack(spacing: 8) {
                Text("배너")
                    .font(.title)
                    .fontWeight(.bold)
                Text("가까운 찾기")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Image(systemName: "market")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 8)
            }
        }
        .padding()
    }
}

struct BannerView: View {
    var body: some View {
        Text("Banner View")
            .font(.title)
            .navigationBarTitle("Banner", displayMode: .inline)
    }
}
