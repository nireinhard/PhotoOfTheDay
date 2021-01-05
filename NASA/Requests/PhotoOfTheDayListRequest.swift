import Foundation

struct PhotoOfTheDayListRequest: Requestable {
    typealias ResponseType = [PhotoOfTheDay]
    var url: URL?
    var defaultResource: [PhotoOfTheDay]?    
}
