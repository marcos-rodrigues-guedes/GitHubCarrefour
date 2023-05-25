import Foundation
import Combine

class UsersInteractor {
    
    var remote: UsersRemoteDataSourceProtocol
    
    init(remote: UsersRemoteDataSourceProtocol = UsersRemoteDataSource.shared) {
        self.remote = remote
    }
}

extension UsersInteractor: UsersInteractorProtocol {
    func getGitHubUsers() -> AnyPublisher<[UserRowViewModel], NetworkError> {
        return remote.getGitHubUsers()
            .map { users in
                let list = users.map {
                    return UserRowViewModel(id: $0.id, nickName: $0.login, urlImage: $0.avatarUrl, url: $0.url)
                }
                return list
            }
            .eraseToAnyPublisher()
    }
}
