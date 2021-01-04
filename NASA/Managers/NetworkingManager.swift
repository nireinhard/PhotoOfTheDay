import Foundation
import Combine
import UIKit

protocol Requestable {
    associatedtype ResponseType: Codable
    var url: URL? { get set }
    var defaultResource: ResponseType? { get set }
    func runRequest() -> AnyPublisher<ResponseType, Error>?
}

extension Requestable {
    func runRequest() -> AnyPublisher<ResponseType, Error>? {
        guard let url = url else {
            return nil
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .tryMap() { (element) in
                guard let res = element.response as? HTTPURLResponse,
                      // currently only handle 200 OK Responses
                      res.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: ResponseType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension Requestable where ResponseType == ImageWrapper {
    mutating func runImageRequest(url: URL) -> AnyPublisher<ImageWrapper, Error> {
        
        guard let defaultResource = defaultResource else {
            return Just(ImageWrapper(image: UIImage()))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
         return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap() { (element) in
                guard let res = element.response as? HTTPURLResponse,
                      // currently only handle 200 OK Responses
                      res.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return ImageWrapper(image: UIImage(data: element.data) ?? defaultResource.image)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class NetworkingManager {
    static var baseURL: URL? = {
        guard let url = URL(string: API.base) else { return nil }
        let pathVariableKey = "api_key"
        let constructedURL = url.withQuery(query: [pathVariableKey : API.key])
        return constructedURL
    }()
}
