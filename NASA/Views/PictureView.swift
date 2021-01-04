import SwiftUI

struct PictureView: View {
    
    @ObservedObject var viewModel = PhotoOfTheDayViewModel()

    var body: some View {
        VStack {
            Text(viewModel.photoOfTheDay.title)
            Image(uiImage: viewModel.image)
        }
    }
}

struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
        PictureView()
    }
}
