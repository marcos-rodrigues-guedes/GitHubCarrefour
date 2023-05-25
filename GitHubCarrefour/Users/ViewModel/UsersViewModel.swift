import Foundation
import Combine

class UsersViewModel: ObservableObject {
    
    @Published var uiState: UsersUIState = .loading
    @Published var opened = false
    @Published var searchText: String = String()
    
    var usersList: [UserRowViewModel] = []
    
    private var cancellable: AnyCancellable?
    
    private let interactor: UsersInteractorProtocol
    
    init(interactor: UsersInteractorProtocol) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func onAppear() {
        self.fechGitHubUsers()
    }
}

extension UsersViewModel: UsersViewModelProtocol {
    
    func fechGitHubUsers() {
        self.uiState = UsersUIState.loading
        self.opened = true
        self.cancellable = self.interactor.getGitHubUsers()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = UsersUIState.error(appError.errorDescription)
                    break
                case .finished:
                    break
                }
                
            } receiveValue: { [weak self] users in
                guard !users.isEmpty else {
                    self?.uiState = UsersUIState.emptyList
                    return
                }
                self?.usersList = users
                self?.uiState = UsersUIState.fullList
            }
    }
    
    var searchResults: [UserRowViewModel] {
        if searchText.isEmpty {
            return usersList
        } else {
            return usersList.filter { $0.nickName.uppercased().contains(searchText.uppercased()) }
        }
    }
}
