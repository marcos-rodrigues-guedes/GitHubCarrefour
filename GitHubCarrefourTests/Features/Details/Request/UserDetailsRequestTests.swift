import XCTest

@testable import GitHubCarrefour

final class UserDetailsRequestTests: XCTestCase {
    
    var request: UserDetailsRequest!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        request = UserDetailsRequest(userName: "user-login")
    }
    
    override func tearDownWithError() throws {
        request = nil
        try super.tearDownWithError()
    }
    
    func testPath() throws {
        XCTAssertEqual(request.path, "/users/user-login")
    }
    
    func testMethod() throws {
        XCTAssertEqual(request.method, .get)
    }
    
    func testHost() throws {
        XCTAssertEqual(request.host, "https://api.github.com")
    }
    
    func testHeader() throws {
        XCTAssertNil(request.header)
    }
    
    func testBody() throws {
        XCTAssertNil(request.body)
    }
    
    func testFullPath() throws {
        XCTAssertEqual("\(request.host)\(request.path)", "https://api.github.com/users/user-login")
    }
}
