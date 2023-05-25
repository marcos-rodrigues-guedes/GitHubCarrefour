import Foundation

struct UserDetailsRequest: RequestProtocol {
    
    private var userName: String
    
    init(userName: String) {
        self.userName = userName
    }
    
    var path: String {
        return "/users/\(userName)"
    }
    var method: RequestMethod {
        return .get
    }
}
