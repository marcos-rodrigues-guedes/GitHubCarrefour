import Foundation

struct UserRepository: Codable {
    let id: Int?
    let name: String?
    let fullName: String?
    let isPrivate: Bool?
    let owner: Owner?
    let description: String?
    let visibility: String?
    let created: String
    let updated: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case isPrivate = "private"
        case owner = "owner"
        case description = "description"
        case visibility = "visibility"
        case created = "created_at"
        case updated = "updated_at"
    }
}

struct Owner: Codable {
    let id: Int?
    let login: String?
}
