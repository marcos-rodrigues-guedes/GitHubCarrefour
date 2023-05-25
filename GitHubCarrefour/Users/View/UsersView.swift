import SwiftUI

struct UsersView: View {
    @ObservedObject var viewModel: UsersViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if case UsersUIState.loading = viewModel.uiState {
                ProgressView("Carregando")
            } else if case UsersUIState.error(let msg) = viewModel.uiState {
                AlertErrorView(action: { viewModel.onAppear() }, msg: msg)
            } else if case UsersUIState.fullList = viewModel.uiState {
                listUsersView()
            } else if case UsersUIState.emptyList = viewModel.uiState {
                emptyView
            } else {
                AlertErrorView(action: { viewModel.onAppear() }, msg: "Erro desconhecido")
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}

extension UsersView {
    var emptyView:some View {
       return Text("Nenhum usuário encontrado")
    }
}

extension UsersView {
    func listUsersView() -> some View {
        return NavigationStack {
            ZStack {
                VStack {
                    List {
                        ForEach(viewModel.searchResults, content: UsersRowView.init(viewModel:))
                    }
                    .listStyle(.automatic)
                    .modifier(CardStyle(color: colorScheme))
                    .searchable(text: $viewModel.searchText, prompt: "nome do usuário")
                }
                .padding(.horizontal, 4)
                .onAppear(perform: {
                    if !viewModel.opened {
                        viewModel.fechGitHubUsers()
                    }
                    
                })
            }.navigationTitle("Usuários")
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView(viewModel: UsersViewModel(interactor: UsersInteractor()))
    }
}
