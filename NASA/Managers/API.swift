import Foundation

struct API {
    static var key: String {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
           let keys = NSDictionary(contentsOfFile: path),
           let apiSecret = keys["api_secret"] as? String {
            return apiSecret
        }
        return "XXX-XXX-XXX-XXX"
    }
    
    static let base = "https://api.nasa.gov"
}
