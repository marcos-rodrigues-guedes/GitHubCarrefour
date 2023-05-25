import Foundation
import Combine

@testable import GitHubCarrefour

class UsersInteractorSpy: UsersInteractorProtocol {
    var remote: UsersRemoteDataSourceProtocol {
        return remoteSpy
    }
    
    var getGitHubUsersClosure: (() -> AnyPublisher<[UserRowViewModel], NetworkError>)?
    
    private let remoteSpy: UsersRemoteDataSourceSpy
    
    init(remote: UsersRemoteDataSourceSpy) {
        self.remoteSpy = remote
    }
    
    func getGitHubUsers() -> AnyPublisher<[UserRowViewModel], NetworkError> {
        return getGitHubUsersClosure?() ?? Empty().eraseToAnyPublisher()
    }
}
