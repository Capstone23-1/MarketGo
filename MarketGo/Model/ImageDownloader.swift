import Alamofire
import UIKit


class ImageDownloader {
    func fetchImageFileInfo(url: String) async throws -> FileInfo {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let fileInfo = try JSONDecoder().decode(FileInfo.self, from: data)
                        continuation.resume(returning: fileInfo)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func fetchImage(fileInfo: FileInfo) async throws -> UIImage? {
        guard let url = URL(string: fileInfo.uploadFileURL!) else { throw URLError(.badURL) }
        let data = try await withCheckedThrowingContinuation { continuation in
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        return UIImage(data: data)
    }
}
