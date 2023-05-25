import Foundation
import Combine

class UsersRemoteDataSource {
    
    private var apiSession = APISession()
    
    static var shared: UsersRemoteDataSource = UsersRemoteDataSource()

    private init() {}
}

extension UsersRemoteDataSource: UsersRemoteDataSourceProtocol {
    
    func getGitHubUsers() -> AnyPublisher<[User], NetworkError> {
        let usersRequest = UsersRequest()
        return apiSession.request(usersRequest)
    }
}
