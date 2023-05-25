import Foundation
import Combine

public class APISession: APISessionProtocol {
    
    var session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ req: RequestProtocol) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: "\(req.host)\(req.path)") else {
            return Fail(error: NetworkError.badURL("Invalid URL"))
                .eraseToAnyPublisher()
        }
        
        let request = configureURLRequest(req: req, url: url)
        
        return session.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server error")
                }
                
                guard (200..<300).contains(httpResponse.statusCode) else {
                    let error = try JSONDecoder().decode(GitHubAPIError.self, from: output.data)
                    throw NetworkError.apiError(code: httpResponse.statusCode, error: error.message)
                }
                
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case let decodingError as DecodingError:
                    return .invalidJSON(decodingError.errorDescription ?? "invalid json")
                case let error as NSError:
                    if error.code == -1009 {
                        return NetworkError.connectionError(error.localizedDescription)
                    }
                    return error as? NetworkError ?? .invalidResponse(error.localizedDescription)
                default:
                    return .invalidResponse(error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func configureURLRequest(req: RequestProtocol, url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = req.method.rawValue
        urlRequest.allHTTPHeaderFields = req.header
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
