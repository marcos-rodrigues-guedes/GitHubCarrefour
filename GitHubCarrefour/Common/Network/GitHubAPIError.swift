import Foundation
import Combine

struct GitHubAPIError: Error, Equatable {
    let message: String
    let errors: [GitHubAPIErrorItem]
}

struct GitHubAPIErrorItem: Decodable, Equatable {
    let resource: String
    let field: String
    let code: String
}

extension GitHubAPIError: Decodable {
    enum CodingKeys: String, CodingKey {
        case message
        case errors
    }

    static func == (lhs: GitHubAPIError, rhs: GitHubAPIError) -> Bool {
        return lhs.message == rhs.message && lhs.errors == rhs.errors
    }
}
