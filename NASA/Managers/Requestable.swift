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
            .tryMap() { (element) in
                try handleStatusCode(response: element.response)
                return element.data
            }
            .receive(on: RunLoop.main)
            .decode(type: ResponseType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension Requestable where ResponseType == ImageWrapper {
    func runImageRequest() -> AnyPublisher<ImageWrapper, Error> {
        guard let defaultResource = defaultResource,
              let resourceURL = url else {
            return Just(ImageWrapper(image: UIImage()))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
         return URLSession.shared.dataTaskPublisher(for: resourceURL)
            .tryMap() { (element) in
                try handleStatusCode(response: element.response)
                return ImageWrapper(image: UIImage(data: element.data) ?? defaultResource.image)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension Requestable {
    private func handleStatusCode(response: URLResponse) throws {
        guard let res = response as? HTTPURLResponse,
              // currently only handle 200 OK Responses
              res.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }
}
