import Foundation
import Combine

protocol UserDetailsInteractorProtocol {
    var remote: UserDetailsRemoteDataSourceProtocol { get }
    func getUsersDetails(with login: String) -> AnyPublisher<UserDetailsModel, NetworkError>
    func getRepositoriesUser(with login: String) -> AnyPublisher<[UserRepositoryRowViewModel], NetworkError>
}
