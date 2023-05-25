import Foundation

import Combine
import Foundation

protocol APISessionProtocol {
    func request<T: Codable>(_ req: RequestProtocol) -> AnyPublisher<T, NetworkError>
}
