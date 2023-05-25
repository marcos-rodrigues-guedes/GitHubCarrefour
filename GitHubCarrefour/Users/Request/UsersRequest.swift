import Foundation

struct UsersRequest: RequestProtocol {
    var path: String {
        return "/users"
    }
    var method: RequestMethod {
        return .get
    }
}
