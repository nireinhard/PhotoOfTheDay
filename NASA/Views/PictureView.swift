import SwiftUI

struct PictureView: View {
    
    @ObservedObject var viewModel = PhotoOfTheDayViewModel()

    var body: some View {
        ZStack {
            Image(uiImage: viewModel.image)
            VStack {
                Text(viewModel.photoOfTheDay.title)
            }
        }
    }
}

struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
        PictureView()
    }
}
