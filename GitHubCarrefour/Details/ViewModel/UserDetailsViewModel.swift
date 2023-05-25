import Foundation
import Combine

final class UserDetailsViewModel: ObservableObject {
    
    @Published var uiState: UsersDetailsUIState = .loading
    @Published var showingRepo = false
    @Published var showingProgress = false
    @Published var showingAlert = false
    
    private let userLogin: String
    
    var userDetails: UserDetailsModel?
    
    var userRepositories = [UserRepositoryRowViewModel]()
    
    private var cancellable = Set<AnyCancellable>()
    private let interactor: UserDetailsInteractorProtocol
    
    init(userLogin: String, interactor: UserDetailsInteractorProtocol) {
        self.interactor = interactor
        self.userLogin = userLogin
    }
    
    deinit {
        cancellable.dispose()
    }
    
    func onAppear() {
        fetchUserDetails()
    }
    
    func showRepos() {
        showingAlert = false
        fetchRepositoriesUser()
    }
}

extension UserDetailsViewModel: UserDetailsViewModelProtocol {
    
   internal func fetchRepositoriesUser() {
       showingProgress.toggle()
       interactor.getRepositoriesUser(with: userLogin)
           .receive(on: DispatchQueue.main)
           .sink { completion in
               switch(completion) {
               case .failure(_):
                   self.showingAlert.toggle()
                   self.showingProgress.toggle()
                   break
               case .finished:
                   break
               }
               
           } receiveValue: { [weak self] repos in
               self?.userRepositories = repos
               self?.showingProgress.toggle()
               self?.showingRepo.toggle()
           }
           .store(in: &cancellable)
   }
    
    internal func fetchUserDetails() {
         self.uiState = UsersDetailsUIState.loading
         interactor.getUsersDetails(with: userLogin)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = UsersDetailsUIState.error(appError.errorDescription)
                    break
                case .finished:
                    break
                }
                
            } receiveValue: { [weak self] details in
                self?.userDetails = details
                self?.uiState = UsersDetailsUIState.success
            }
            .store(in: &cancellable)
    }
}
