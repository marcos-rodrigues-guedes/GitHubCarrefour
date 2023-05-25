import XCTest
import Combine

@testable import GitHubCarrefour

class UsersInteractorTests: XCTestCase {
    var sut: UsersInteractor!
    var remoteDataSourceSpy: UsersRemoteDataSourceSpy!

    override func setUp() {
        super.setUp()
        remoteDataSourceSpy = UsersRemoteDataSourceSpy()
        sut = UsersInteractor(remote: remoteDataSourceSpy)
    }

    override func tearDown() {
        sut = nil
        remoteDataSourceSpy = nil
        super.tearDown()
    }

    func testGetGitHubUsers_Success() {
        // Cria um Publisher de exemplo com uma lista de usuários
        let users = UserListFactoryStub.makeUserList()
        let publisher = Just(users)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()

        // Define o comportamento esperado para o método getGitHubUsers() no mock
        remoteDataSourceSpy.getGitHubUsersClosure = {
            return publisher
        }

        // Chama o método sendo testado
        let result = sut.getGitHubUsers()

        // Verifica se o resultado é igual ao Publisher esperado
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
            XCTAssertEqual(receivedUsers.first?.nickName, users.first?.login)
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetGitHubUsers_Failure() {
        // Crie um Publisher de exemplo com um erro de rede
        let error = NetworkError.badRequest(code: 0, error: "Erro de Conexão")
        let publisher = Fail<[User], NetworkError>(error: error)
            .eraseToAnyPublisher()

        // Defina o comportamento esperado para o método getGitHubUsers() no mock
        remoteDataSourceSpy.getGitHubUsersClosure = {
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
                XCTAssertEqual(receivedError, error)
                expectation.fulfill()
            }
        } receiveValue: { _ in
            XCTFail("Unexpected received value")
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetGitHubUsers_EmptyResult() {
        // Crie um Publisher de exemplo com uma lista vazia de usuários
        let users: [User] = []
        let publisher = Just(users)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()

        // Defina o comportamento esperado para o método getGitHubUsers() no spy
        remoteDataSourceSpy.getGitHubUsersClosure = {
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

    func testGetGitHubUsers_NetworkError() {
        // Cria um Publisher de exemplo com um erro de rede
        let error = NetworkError.connectionError("Erro de Conexão")
        let publisher = Fail<[User], NetworkError>(error: error)
            .eraseToAnyPublisher()

        // Define o comportamento esperado para o método getGitHubUsers() no spy
        remoteDataSourceSpy.getGitHubUsersClosure = {
            return publisher
        }

        // Chama o método sendo testado
        let result = sut.getGitHubUsers()

        // Verifica se o resultado é igual ao Publisher esperado
        let expectation = XCTestExpectation(description: "Get GitHub Users")
        _ = result.sink { completion in
            switch completion {
            case .finished:
                XCTFail("Unexpected successful completion")
            case .failure(let receivedError):
                // O teste passa se o erro recebido for igual ao erro esperado
                XCTAssertEqual(receivedError, error)
                expectation.fulfill()
            }
        } receiveValue: { _ in
            XCTFail("Unexpected received value")
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
