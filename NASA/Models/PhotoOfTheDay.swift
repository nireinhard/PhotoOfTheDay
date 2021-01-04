import Foundation

struct PhotoOfTheDay: Decodable {
    let title: String
    let explanation: String
    let url: URL?
    let copyright: String?
    let date: String
    
    init() {
        self.title = ""
        self.explanation = ""
        self.date = ""
        self.url = nil
        self.copyright = nil
    }
}
