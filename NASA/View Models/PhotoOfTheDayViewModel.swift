import Foundation
import Combine
import UIKit

class PhotoOfTheDayViewModel: ObservableObject {
    private let request = PhotoOfTheDayRequest()
    private var subscriptions = Set<AnyCancellable>()
    
    lazy var defaultImage: UIImage = {
        guard let defaultImage = UIImage(named: "defaultPhoto") else {
            return UIImage()
        }
        return defaultImage
    }()
    
    @Published var photoOfTheDay = PhotoOfTheDay() {
        didSet {
            guard let url = photoOfTheDay.url else {
                return
            }
            fetchImage(url: url)
        }
    }
    
    @Published var image: UIImage = UIImage()
    
    init() {
        self.image = defaultImage
        
        if let publisher = request.runRequest() {
            publisher.sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("failed at \(error)")
                case .finished:
                    break
                }
            } receiveValue: { (photo) in
                print(photo)
                self.photoOfTheDay = photo
            }.store(in: &subscriptions)
        }
    }
    
    private func fetchImage(url: URL) {
        
        
        
//        ResourceRequest(url: url, defaultResource: <#ResourceRequest.ResponseType#>).runRequest()!.sink { (completion) in
//            switch completion {
//            case .failure(let error):
//                print("failed at \(error)")
//            case .finished:
//                break
//            }
//        } receiveValue: { (imageWrapper) in
//            self.image = imageWrapper.image
//        }.store(in: &subscriptions)
    }
}
