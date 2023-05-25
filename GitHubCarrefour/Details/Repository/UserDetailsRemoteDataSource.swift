import Foundation
import Combine

class UserDetailsRemoteDataSource {
    
    static var shared: UserDetailsRemoteDataSource = UserDetailsRemoteDataSource()
     
    private init() {}
}

extension UserDetailsRemoteDataSource: UserDetailsRemoteDataSourceProtocol {
    
    func getUsersDetails(with login: String) -> AnyPublisher<UserDetails, NetworkError> {
        return apiSession.request(UserDetailsRequest(userName: login))
    }
    
    func getRepositoriesUser(with login: String) -> AnyPublisher<[UserRepository], NetworkError> {
        return apiSession.request(UserRepositoriesRequest(userName: login))
    }
}
