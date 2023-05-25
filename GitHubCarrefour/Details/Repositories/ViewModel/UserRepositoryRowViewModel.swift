import Foundation

struct UserRepositoryRowViewModel: Identifiable, Equatable {
    var id: Int
    var name: String
    var fullName: String
    var description: String
    var visibility: String
    var created: String
    var updated: String
}
