import Foundation

extension URL {
    typealias StringDict = [String:String]
    
    // helper method to add query items of type String Dictionary to an existing URL
    func withQuery(query q: StringDict) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = q.map { URLQueryItem(name: $0, value: $1) }
        return components?.url
    }
}
