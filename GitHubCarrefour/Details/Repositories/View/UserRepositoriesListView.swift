import SwiftUI

struct UserRepositoriesListView: View {
    
    var listRepositories: [UserRepositoryRowViewModel]
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(listRepositories, content: UserRepositoryRowView.init(viewModel:))
                }
                .listStyle(.automatic)
                .modifier(CardStyle(color: colorScheme))
            }
        }
    }
}

struct UserRepositoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VStack {
                UserRepositoriesListView(listRepositories: [
                    UserRepositoryRowViewModel(
                        id: 0,
                        name: "30daysoflaptops.github.io",
                        fullName: "mojombo/30daysoflaptops.github.io",
                        description: "Destroy your Atom editor, Asteroids style!",
                        visibility: "Public",
                        created: "10/03/2023",
                        updated: "10/02/2023")])
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("iPhone 11")
            .preferredColorScheme($0)
        }
        
    }
}
