import Foundation
import Combine

protocol UserDetailsRemoteDataSourceProtocol {
    var apiSession: APISessionProtocol { get }
    func getUsersDetails(with login: String) -> AnyPublisher<UserDetails, NetworkError>
    func getRepositoriesUser(with login: String) -> AnyPublisher<[UserRepository], NetworkError>
}

extension UserDetailsRemoteDataSourceProtocol {
    var apiSession: APISessionProtocol {
        return APISession()
    }
}
