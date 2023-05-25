import Foundation
import Combine

@testable import GitHubCarrefour

class UserDetailsInteractorSpy: UserDetailsInteractorProtocol {
    
    var remote: UserDetailsRemoteDataSourceProtocol {
        return remoteSpy
    }
    
    var getUsersDetailsClosure: (() -> AnyPublisher<UserDetailsModel, NetworkError>)?
    
    var getRepositoriesUserClosure: (() -> AnyPublisher<[UserRepositoryRowViewModel], NetworkError>)?
    
    private let remoteSpy: UserDetailsRemoteDataSourceSpy
    
    init(remote: UserDetailsRemoteDataSourceSpy) {
        self.remoteSpy = remote
    }
    
    func getUsersDetails(with login: String) -> AnyPublisher<UserDetailsModel, NetworkError> {
        return getUsersDetailsClosure?() ?? Empty().eraseToAnyPublisher()
    }
    
    func getRepositoriesUser(with login: String) -> AnyPublisher<[UserRepositoryRowViewModel], NetworkError> {
        return getRepositoriesUserClosure?() ?? Empty().eraseToAnyPublisher()
    }
}
