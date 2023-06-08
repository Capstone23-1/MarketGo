import SwiftUI

struct MarketMapView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var scale: CGFloat = 1.0
    @EnvironmentObject var userModel: UserModel
    @State var isLoading = false
    @State var isUnavailable = false
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                ScrollView([.horizontal, .vertical], showsIndicators: false) {
                    if isUnavailable {
                        Text("지도를 제공하지 않는 시장입니다.")
                            .font(.title)
                            .padding()
                    } else if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                            .scaleEffect(scale)
                    }
                }

            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { scale += 0.1 }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.white.opacity(0.6))
                            .cornerRadius(15)
                    }
                    Button(action: { scale -= 0.1 }) {
                        Image(systemName: "minus")
                            .padding()
                            .background(Color.white.opacity(0.6))
                            .cornerRadius(15)
                    }
                }
            }.padding()
            .font(.largeTitle)
            
            if isLoading {
                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .frame(width: 100, height: 100)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    .shadow(radius: 10)
            }
            
        }.onAppear {
            fetchImage()
        }
    }
    
    func fetchImage() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            Task {
                guard let fileId = userModel.currentUser?.interestMarket?.marketMap?.fileID, fileId != 0 else {
                    isUnavailable = true
                    isLoading = false
                    return
                }
                do {
                    print("fileId: \(fileId)")
                    let fileInfo = try await ImageDownloader().fetchImageFileInfo(url: "http://3.34.33.15:8080/file/\(fileId)")
                    selectedImage = try await ImageDownloader().fetchImage(fileInfo: fileInfo)
                } catch {
                    print("Failed to fetch image: \(error)")
                }
                isLoading = false
            }
        }
    }
}
