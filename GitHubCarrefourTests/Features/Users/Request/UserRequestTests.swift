
import XCTest

@testable import GitHubCarrefour

final class UserRequestTests: XCTestCase {
    
    var request: UsersRequest!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        request = UsersRequest()
    }
    
    override func tearDownWithError() throws {
        request = nil
        try super.tearDownWithError()
    }
    
    func testPath() throws {
        XCTAssertEqual(request.path, "/users")
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
        XCTAssertEqual("\(request.host)\(request.path)", "https://api.github.com/users")
    }
}
