import Foundation
import Combine

@testable import GitHubCarrefour

class UsersRemoteDataSourceSpy: UsersRemoteDataSourceProtocol {
    var getGitHubUsersClosure: (() -> AnyPublisher<[User], NetworkError>)?

    func getGitHubUsers() -> AnyPublisher<[User], NetworkError> {
        guard let closure = getGitHubUsersClosure else {
            fatalError("getGitHubUsersClosure not implemented")
        }
        return closure()
    }
}
