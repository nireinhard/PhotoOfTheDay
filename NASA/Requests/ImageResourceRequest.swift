import UIKit
import Combine

struct ImageResourceRequest: Requestable {
    // ImageWrapper used because it is easier to conform to Codable
    var defaultResource: ImageWrapper?
    typealias ResponseType = ImageWrapper
    
    var url: URL?
    
    init(url: URL, defaultResource: ResponseType) {
        self.url = url
        self.defaultResource = defaultResource
    }
}
