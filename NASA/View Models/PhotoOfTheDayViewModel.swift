import Foundation
import Combine
import UIKit

class PhotoOfTheDayViewModel: ObservableObject {
    
    @Published var photoOfTheDay = PhotoOfTheDay() {
        didSet {
            guard let url = photoOfTheDay.url else {
                return
            }
            fetchImage(url: url)
        }
    }
    
    @Published var image: UIImage = UIImage()
    
    private let request = PhotoOfTheDayRequest()
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var defaultImage: UIImage = {
        guard let defaultImage = UIImage(named: "defaultPhoto") else {
            return UIImage()
        }
        return defaultImage
    }()
    
    init() {
        self.image = defaultImage
        getPhotoOfTheDay()
    }
    
    private func getPhotoOfTheDay() {
        if let publisher = request.runRequest() {
            publisher.sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("failed at \(error)")
                case .finished:
                    break
                }
            } receiveValue: { (photo) in
                self.photoOfTheDay = photo
            }.store(in: &subscriptions)
        }
    }
    
    private func fetchImage(url: URL) {
        
        let publisher = ImageResourceRequest(url: url, defaultResource: defaultImage.imageWrapper()).runImageRequest()
        
        publisher.sink { (completion) in
            switch completion {
            case .failure(let error):
                print("failed at \(error)")
            case .finished:
                break
            }
        } receiveValue: { (imageWrapper) in
            self.image = imageWrapper.image
        }.store(in: &subscriptions)
    }
}
