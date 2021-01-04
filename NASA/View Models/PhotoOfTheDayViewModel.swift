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
        request.runRequest().sink { (completion) in
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
    
    private func fetchImage(url: URL) {
        ResourceRequest(url: url, defaultResource: defaultImage).runRequest().sink { (completion) in
            switch completion {
            case .failure(let error):
                print("failed at \(error)")
            case .finished:
                break
            }
        } receiveValue: { (image) in
            self.image = image
        }.store(in: &subscriptions)
    }
}
