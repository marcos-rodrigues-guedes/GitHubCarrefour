import Foundation

struct UserRepositoriesRequest: RequestProtocol {
    
    private var userName: String
    
    init(userName: String) {
        self.userName = userName
    }
    
    var path: String {
        return "/users/\(userName)/repos"
    }
    var method: RequestMethod {
        return .get
    }
}
