
import Foundation
import Combine

@testable import GitHubCarrefour

class UserDetailsRemoteDataSourceSpy: UserDetailsRemoteDataSourceProtocol {
    
    var getUsersDetailsClosure: (() -> AnyPublisher<UserDetails, NetworkError>)?
    var getRepositoriesUserClosure: (() -> AnyPublisher<[UserRepository], NetworkError>)?
    
    func getUsersDetails(with login: String) -> AnyPublisher<UserDetails, NetworkError> {
        guard let closure = getUsersDetailsClosure else {
            fatalError("getGitHubUsersClosure not implemented")
        }
        return closure()
    }
    
    func getRepositoriesUser(with login: String) -> AnyPublisher<[UserRepository], NetworkError> {
        guard let closure = getRepositoriesUserClosure else {
            fatalError("getGitHubUsersClosure not implemented")
        }
        return closure()
    }
}
