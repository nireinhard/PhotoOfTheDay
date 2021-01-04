import Foundation
import Combine

class PhotoOfTheDayRequest: Requestable {
    typealias ResponseType = PhotoOfTheDay

    var url: URL? = NetworkingManager.baseURL?.appendingPathComponent("/planetary/apod")
    
    func runRequest() -> AnyPublisher<ResponseType, Error> {
        guard let url = url else {
            return Just(PhotoOfTheDay())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        return NetworkingManager.runRequest(url: url, result: ResponseType.self)
    }
}
