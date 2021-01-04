import UIKit
import Combine

class ResourceRequest: Requestable {
    var defaultResource: ImageWrapper?
    typealias ResponseType = ImageWrapper
    
    var url: URL?
    
    init(url: URL, defaultResource: ResponseType) {
        self.url = url
        self.defaultResource = defaultResource
    }
}
