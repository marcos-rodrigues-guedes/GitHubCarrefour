import Foundation
import Combine

protocol UsersRemoteDataSourceProtocol {
    var apiSession: APISessionProtocol { get set }
    func getGitHubUsers() -> AnyPublisher<[User], NetworkError>
}

extension UsersRemoteDataSourceProtocol {
    var apiSession: APISessionProtocol {
        get { apiSession }
        set { apiSession = newValue }
    }
}
