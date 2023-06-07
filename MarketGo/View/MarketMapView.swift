import SwiftUI

struct MarketMapView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var scale: CGFloat = 1.0
    @EnvironmentObject var userModel: UserModel
    @State var isLoading = false
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                ScrollView([.horizontal, .vertical], showsIndicators: false) {
                    if let image = selectedImage {
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
                do {
                    let fileId = (userModel.currentUser?.interestMarket?.marketMap?.fileID)!
                    print("fileId: \(String(describing: fileId))")
                    let fileInfo = try await ImageDownloader().fetchImageFileInfo(url: "http://3.34.33.15:8080/file/\(String(describing: fileId))")
                    selectedImage = try await ImageDownloader().fetchImage(fileInfo: fileInfo)
                } catch {
                    print("Failed to fetch image: \(error)")
                }
                isLoading = false
            }
        }
    }
}
