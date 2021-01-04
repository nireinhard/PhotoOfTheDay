import Foundation

struct API {
    
    private static let keyResourceFileName = "Keys"
    private static let keyResourceFileType = "plist"
    private static let resourceKeyName = "api_secret"
    private static let dummySecret = "XXX-XXX-XXX-XXX"
    
    static var key: String {
        if let path = Bundle.main.path(forResource: keyResourceFileName, ofType: keyResourceFileType),
           let keys = NSDictionary(contentsOfFile: path),
           let apiSecret = keys[resourceKeyName] as? String {
            return apiSecret
        }
        return dummySecret
    }
    
    static let base = "https://api.nasa.gov"
}
