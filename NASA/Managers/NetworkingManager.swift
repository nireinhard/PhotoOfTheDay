import Foundation
import Combine
import UIKit

protocol Requestable {
    associatedtype ResponseType
    var url: URL? { get set }
    func runRequest() -> AnyPublisher<ResponseType, Error>
}

class NetworkingManager {
    
    static var baseURL: URL? = {
        guard let url = URL(string: API.base) else { return nil }
        let pathVariableKey = "api_key"
        let constructedURL = url.withQuery(query: [pathVariableKey : API.key])
        return constructedURL
    }()
     
    static func runRequest<T: Decodable>(url: URL, result: T.Type) -> AnyPublisher<T, Error> {
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
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static func runImageRequest(url: URL) -> AnyPublisher<UIImage, Error> {
         return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap() { (element) in
                guard let res = element.response as? HTTPURLResponse,
                      // currently only handle 200 OK Responses
                      res.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return  UIImage(data: element.data)
            }
            .replaceNil(with: UIImage())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
