import Foundation
import Combine

@testable import GitHubCarrefour

class APISessionSpy: APISessionProtocol {
    
    var requestClosure: ((RequestProtocol) -> AnyPublisher<Data, NetworkError>)?
    
    func request<T: Codable>(_ req: RequestProtocol) -> AnyPublisher<T, NetworkError> {
        guard let closure = requestClosure else {
            fatalError("requestClosure not implemented")
        }
        return closure(req)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return .invalidJSON("decode error")
                }
            }
            .eraseToAnyPublisher()
    }
    
}
