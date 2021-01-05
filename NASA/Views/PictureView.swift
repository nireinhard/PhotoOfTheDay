import SwiftUI

struct PictureView: View {
    
    @ObservedObject var viewModel = PhotoOfTheDayViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: viewModel.image)
                .resizable()
            
            Text(viewModel.photoOfTheDay.title)
                .font(.title)
                .foregroundColor(.primary)
            HStack {
                Text(viewModel.photoOfTheDay.url?.absoluteString ?? "")
                Spacer()
                Text(viewModel.photoOfTheDay.copyright ?? "")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)

            Divider()
            Text(viewModel.photoOfTheDay.explanation)
        }.padding()
    }
}

struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
        PictureView()
    }
}
