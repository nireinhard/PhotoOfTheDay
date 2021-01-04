import UIKit
import Combine

class ResourceRequest: Requestable {
    
    typealias ResponseType = UIImage
    
    var url: URL?
    var defaultResoruce: ResponseType
    
    init(url: URL, defaultResource: ResponseType) {
        self.url = url
        self.defaultResoruce = defaultResource
    }
    
    func runRequest() -> AnyPublisher<ResponseType, Error> {
        guard let url = url else {
            return Just(defaultResoruce)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        return NetworkingManager.runImageRequest(url: url)
    }
}
