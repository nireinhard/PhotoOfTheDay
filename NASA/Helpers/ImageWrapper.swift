import UIKit

public struct ImageWrapper: Codable {
    public let image: UIImage
    
    public enum CodingKeys: String, CodingKey {
        case image
    }

    struct WrapperError: Error {
    }
    
    public init(image: UIImage) {
        self.image = image
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: CodingKeys.image)
        
        guard let image = UIImage(data: data) else {
            throw WrapperError()
        }
        
        self.image = image
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        guard let data = image.pngData() else {
            throw WrapperError()
        }
        
        try container.encode(data, forKey: CodingKeys.image)
    }
}
