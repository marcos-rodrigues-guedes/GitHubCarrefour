

/*
class UsersRemoteDataSourceTests: XCTestCase {
    var sut: UsersRemoteDataSource!
    var apiSessionSpy: APISessionSpy!

    override func setUp() {
        super.setUp()
        apiSessionSpy = APISessionSpy()
        sut = UsersRemoteDataSource.shared
        sut.apiSession = apiSessionSpy
    }

    override func tearDown() {
        sut = nil
        apiSessionSpy = nil
        super.tearDown()
    }

    func testGetGitHubUsers_Success() {
        // Crie um exemplo de resposta bem-sucedida
        let users = UserListFactoryStub.makeUserList()
        let response = HTTPURLResponse(url: URL(string: "https://api.github.com/users")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let publisher = Just(try! JSONEncoder().encode(users))
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()

        // Defina o comportamento esperado para a chamada de API no mock
        apiSessionSpy.requestClosure = { request in
            // Verifique se a solicitação está correta (opcional)
           // XCTAssertEqual(request.url?.absoluteString, "https://api.github.com/users")

            // Retorne o Publisher simulando a resposta bem-sucedida
            return publisher
        }

        // Chame o método sendo testado
        let result = sut.getGitHubUsers()

        // Verifique se o resultado é igual ao Publisher esperado
        let expectation = XCTestExpectation(description: "Get GitHub Users")
        _ = result.sink { completion in
            switch completion {
            case .finished:
                // O teste passa se a conclusão for .finished
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected failure: \(error)")
            }
        } receiveValue: { receivedUsers in
            // O teste passa se a lista de usuários recebidos for igual à lista esperada
            XCTAssertEqual(receivedUsers, users)
        }

        wait(for: [expectation], timeout: 1.0)
    }
    

    func testGetGitHubUsers_Failure() {
        // Crie um exemplo de resposta com erro
        let error = NetworkError.connectionError("")
        let publisher = Fail<Data, NetworkError>(error: error)
            .eraseToAnyPublisher()

        // Defina o comportamento esperado para a chamada de API no mock
        apiSessionSpy.requestClosure = { request in
            // Retorne o Publisher simulando uma falha na chamada de API
            return publisher
        }

        // Chame o método sendo testado
        let result = sut.getGitHubUsers()

        // Verifique se o resultado é igual ao Publisher esperado
        let expectation = XCTestExpectation(description: "Get GitHub Users")
        _ = result.sink { completion in
            switch completion {
            case .finished:
                XCTFail("Unexpected successful completion")
            case .failure(let receivedError):
                // O teste passa se o erro recebido for igual ao erro esperado
                XCTAssertEqual(receivedError, NetworkError.connectionError(""))
                expectation.fulfill()
            }
        } receiveValue: { _ in
            XCTFail("Unexpected received value")
        }

        wait(for: [expectation], timeout: 1.0)
    }
    */

/* func testGetGitHubUsers_EmptyResponse() {
 // Crie um exemplo de resposta vazia
 let response = HTTPURLResponse(url: URL(string: "https://api.github.com/users")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
 let publisher = Just(Data())
 .setFailureType(to: NetworkError.self)
 .eraseToAnyPublisher()
 
 // Defina o comportamento esperado para a chamada de API no mock
 apiSessionSpy.requestClosure = { request in
 // Retorne o Publisher simulando uma resposta vazia
 return publisher
 }
 
 // Chame o método sendo testado
 let result = sut.getGitHubUsers()
 
 // Verifique se o resultado é igual ao Publisher esperado
 let expectation = XCTestExpectation(description: "Get GitHub Users")
 _ = result.sink { completion in
 switch completion {
 case .finished:
 // O teste passa se a conclusão for .finished
 expectation.fulfill()
 case .failure(let error):
 XCTFail("Unexpected failure: \(error)")
 }
 } receiveValue: { receivedUsers in
 // O teste passa se a lista de usuários recebidos for vazia
 XCTAssertTrue(receivedUsers.isEmpty)
 }
 
 wait(for: [expectation], timeout: 1.0)
 }
 
 }
 */
