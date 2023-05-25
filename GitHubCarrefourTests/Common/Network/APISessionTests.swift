import XCTest
import Combine

@testable import GitHubCarrefour

class APISessionTests: XCTestCase {
    var sut: APISession!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        sut = APISession(session: urlSession)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
        
        super.tearDown()
    }
    
    func testRequest_SuccessfulResponse() {
        // Given
        let expectation = XCTestExpectation(description: "Successful response")
        let userRequest = UsersRequest()
        let testResponse =
            """
            [{
                "login": "mojombo",
                "id": 1,
                "node_id": "MDQ6VXNlcjE=",
                "avatar_url": "https://avatars.githubusercontent.com/u/1?v=4",
                "gravatar_id": "",
                "url": "https://api.github.com/users/mojombo",
                "html_url": "https://github.com/mojombo",
                "followers_url": "https://api.github.com/users/mojombo/followers",
                "following_url": "https://api.github.com/users/mojombo/following{/other_user}",
                "gists_url": "https://api.github.com/users/mojombo/gists{/gist_id}",
                "starred_url": "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
                "subscriptions_url": "https://api.github.com/users/mojombo/subscriptions",
                "organizations_url": "https://api.github.com/users/mojombo/orgs",
                "repos_url": "https://api.github.com/users/mojombo/repos",
                "events_url": "https://api.github.com/users/mojombo/events{/privacy}",
                "received_events_url": "https://api.github.com/users/mojombo/received_events",
                "type": "User",
                "site_admin": false
            }]
            """.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "https://api.github.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, testResponse)
        }
        
        let publisher: AnyPublisher<[User], NetworkError> = sut.request(userRequest)
        
        publisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Unexpected error: \(error)")
                }
            }, receiveValue: { response in
                XCTAssertFalse(response.isEmpty)
                XCTAssertEqual(response.first?.url, "https://api.github.com/users/mojombo")
            })
            .store(in: &cancellables)
    
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testRequest_InvalidResponse() {
        // falta o atributo login
        let expectation = XCTestExpectation(description: "Invalid response")
        let userRequest = UsersRequest()
        let testResponse =
            """
            [{
                "id": 1,
                "node_id": "MDQ6VXNlcjE=",
                "avatar_url": "https://avatars.githubusercontent.com/u/1?v=4",
                "gravatar_id": "",
                "url": "https://api.github.com/users/mojombo",
                "html_url": "https://github.com/mojombo",
                "followers_url": "https://api.github.com/users/mojombo/followers",
                "following_url": "https://api.github.com/users/mojombo/following{/other_user}",
                "gists_url": "https://api.github.com/users/mojombo/gists{/gist_id}",
                "starred_url": "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
                "subscriptions_url": "https://api.github.com/users/mojombo/subscriptions",
                "organizations_url": "https://api.github.com/users/mojombo/orgs",
                "repos_url": "https://api.github.com/users/mojombo/repos",
                "events_url": "https://api.github.com/users/mojombo/events{/privacy}",
                "received_events_url": "https://api.github.com/users/mojombo/received_events",
                "type": "User",
                "site_admin": false
            }]
            """.data(using: .utf8)
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "https://api.github.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, testResponse)
        }
        
        let publisher: AnyPublisher<[User], NetworkError> = sut.request(userRequest)
        
        publisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTAssertEqual(error , NetworkError.invalidJSON("invalid json"))
                    expectation.fulfill()
                }
            }, receiveValue: { response in
                
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
        
        
    }
    
    func testRequest_FailureResponse() {
        let expectation = XCTestExpectation(description: "Failure response")
        let userRequest = UsersRequest()
        let testResponse =
             """
            {
              "message": "Validation Failed",
              "errors": [
                {
                  "resource": "Issue",
                  "field": "title",
                  "code": "missing_field"
                }
              ]
            }
            """.data(using: .utf8)
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "https://api.github.com")!, statusCode: 422, httpVersion: nil, headerFields: nil)!
            return (response, testResponse)
        }
        
        let publisher: AnyPublisher<[User], NetworkError> = sut.request(userRequest)
        
        publisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTAssertEqual(error , NetworkError.apiError(code: 422, error: "Validation Failed"))
                    expectation.fulfill()
                }
            }, receiveValue: { response in
            
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
}
