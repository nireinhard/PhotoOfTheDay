import Foundation
import Combine

class PhotoOfTheDayViewModel: ObservableObject {
    
    let request = PhotoOfTheDayRequest()
    
    @Published var photoOfTheDay = PhotoOfTheDay()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        request.runRequest().sink { (completion) in
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
