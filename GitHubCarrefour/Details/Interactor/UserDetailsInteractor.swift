import Foundation
import Combine

class UserDetailsInteractor {
    var remote: UserDetailsRemoteDataSourceProtocol
    
    init(remote: UserDetailsRemoteDataSourceProtocol = UserDetailsRemoteDataSource.shared) {
        self.remote = remote
    }
}

extension UserDetailsInteractor: UserDetailsInteractorProtocol {
    func getUsersDetails(with login: String) -> AnyPublisher<UserDetailsModel, NetworkError> {
        return remote.getUsersDetails(with: login).map { return $0.toUserDetailsModel}.eraseToAnyPublisher()
    }
    
    func getRepositoriesUser(with login: String) -> AnyPublisher<[UserRepositoryRowViewModel], NetworkError> {
        return remote.getRepositoriesUser(with: login).map {
            let models = $0.map {
                return $0.toUserRepositoryRowModel
            }
            return models
        }.eraseToAnyPublisher()
    }
}
