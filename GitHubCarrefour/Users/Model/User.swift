import Foundation

struct User: Codable, Equatable {
    let id: Int
    let login: String
    let url: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case url = "url"
        case avatarUrl = "avatar_url"
    }
}
