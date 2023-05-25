import Foundation
import Combine

protocol UsersInteractorProtocol {
    var remote: UsersRemoteDataSourceProtocol { get }
    func getGitHubUsers() -> AnyPublisher<[UserRowViewModel], NetworkError>
}
