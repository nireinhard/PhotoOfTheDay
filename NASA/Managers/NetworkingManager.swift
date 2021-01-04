import Foundation
import Combine

protocol Requestable {
    associatedtype ResponseType
    var url: URL? { get set }
    func runRequest() -> AnyPublisher<ResponseType, Error>
}

class NetworkingManager: ObservableObject {
    
    static var baseURL: URL? = {
        guard let url = URL(string: API.base) else { return nil }
        let constructedURL = url.withQuery(query: ["api_key" : API.key])
        return constructedURL
    }()
    
    @Published var photoOfTheDay: PhotoOfTheDay = PhotoOfTheDay()
     
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
}
