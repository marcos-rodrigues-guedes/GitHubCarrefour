import SwiftUI

struct UsersRowView: View {
    
    let viewModel: UserRowViewModel
    
    var body: some View {
        NavigationLink {
             viewModel.userDetailsView(userDetailsInteractor: UserDetailsInteractor())
        } label: {
            VStack {
                HStack(spacing: 30) {
                    AsyncImage(url: URL(string: viewModel.urlImage)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 50, maxHeight: 120)
                                            .clipShape(Circle())
                                    case .failure:
                                        Image(systemName: "photo")
                                    @unknown default:
                                        EmptyView()
                                    }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.nickName.uppercased())
                            .font(.title3)
                            .padding(.bottom, 1)
                            .multilineTextAlignment(.leading)
                            .bold()
                        Text("id: \(viewModel.id)")
                            .font(.footnote)

                    }
                    Spacer()
                }
            }
        }
    }
}

struct UsersRowView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
          VStack {
              UsersRowView(viewModel: UserRowViewModel(nickName: "mojombo", urlImage: "https://avatars.githubusercontent.com/u/1?v=4", url: ""))
          }.padding()
                .frame(maxWidth: .infinity, maxHeight: 200)
          .previewDevice("iPhone 11")
          .preferredColorScheme($0)
        }
    }
}
