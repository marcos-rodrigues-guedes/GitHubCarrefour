import Foundation

struct UserDetails: Codable {
    let id: Int?
    let login: String?
    let name: String?
    let email: String?
    let location: String?
    let blog: String?
    let twitter: String?
    let company: String?
    let avatarUrl: String?
    let reposUrl: String?
    let followers: Int64?
    let following: Int64?
    let created: String?
    let updated: String?
    let publicResp: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case name = "name"
        case email = "email"
        case location = "location"
        case blog = "blog"
        case twitter = "twitter_username"
        case company = "company"
        case avatarUrl = "avatar_url"
        case reposUrl = "repos_url"
        case followers = "followers"
        case following = "following"
        case created = "created_at"
        case updated = "updated_at"
        case publicResp = "public_repos"
    }
}
