import Foundation
import Combine

class PhotoOfTheDayRequest: Requestable {
    
    typealias ResponseType = PhotoOfTheDay
    var url: URL? = NetworkingManager.baseURL?.appendingPathComponent("/planetary/apod")
    var defaultResource: ResponseType?
    
}
