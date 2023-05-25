import Foundation
import XCTest
import Combine

@testable import GitHubCarrefour

class UserDetailsInteractorTests: XCTestCase {
    
    var remoteDataSourceSpy: UserDetailsRemoteDataSourceSpy!
    var sut: UserDetailsInteractor!

    override func setUp() {
        super.setUp()
        remoteDataSourceSpy = UserDetailsRemoteDataSourceSpy()
        sut = UserDetailsInteractor(remote: remoteDataSourceSpy)
    }

    override func tearDown() {
        sut = nil
        remoteDataSourceSpy = nil
        super.tearDown()
    }

    func testGetUsersDetails_Success() {
        // Cria um Publisher de exemplo de detalhes do usuário
        let details = UserDetailsFactoryStub.makeUserDetail()
        let publisher = Just(details)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()

        // Define o comportamento esperado para o método testGetUsersDetails() no mock
        remoteDataSourceSpy.getUsersDetailsClosure = {
            return publisher
        }

        // Chama o método sendo testado
        let result = sut.getUsersDetails(with: "user")

        // Verifica se o resultado é igual ao Publisher esperado
        let expectation = XCTestExpectation(description: "Get GitHub Users Details")
        _ = result.sink { completion in
            switch completion {
            case .finished:
                // O teste passa se a conclusão for .finished
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected failure: \(error)")
            }
        } receiveValue: { receivedDetails in
            
            XCTAssertNotNil(receivedDetails)
            XCTAssertEqual(receivedDetails.name, details.name)
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetUsersDetails_Failure() {
        // Cria um Publisher de exemplo com um erro de rede
        let error = NetworkError.badRequest(code: 0, error: "Erro de Conexão")
        let publisher = Fail<UserDetails, NetworkError>(error: error)
            .eraseToAnyPublisher()

        // Define o comportamento esperado para o método testGetUsersDetails() no mock
        remoteDataSourceSpy.getUsersDetailsClosure = {
            return publisher
        }

        // Chama o método sendo testado
        let result = sut.getUsersDetails(with: "user")

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

    func testGetUsersDetails_NetworkError() {
        // Cria um Publisher de exemplo com um erro de rede
        let error = NetworkError.connectionError("Erro de Conexão")
        let publisher = Fail<UserDetails, NetworkError>(error: error)
            .eraseToAnyPublisher()

        // Define o comportamento esperado para o método testGetUsersDetails() no spy
        remoteDataSourceSpy.getUsersDetailsClosure = {
            return publisher
        }

        // Chama o método sendo testado
        let result = sut.getUsersDetails(with: "user")

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
    
    func testGetUserRespositories_Success() {
        
        let repositories = UserDetailsFactoryStub.makeUserRepositoryList()
        let publisher = Just(repositories)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()

        // Define o comportamento esperado para o método testGetUserRespositories() no mock
        remoteDataSourceSpy.getRepositoriesUserClosure = {
            return publisher
        }

        // Chama o método sendo testado
        let result = sut.getRepositoriesUser(with: "user")

        // Verifica se o resultado é igual ao Publisher esperado
        let expectation = XCTestExpectation(description: "Get GitHub Users Repository")
        _ = result.sink { completion in
            switch completion {
            case .finished:
                // O teste passa se a conclusão for .finished
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected failure: \(error)")
            }
        } receiveValue: { receivedRepos in
            XCTAssertFalse(receivedRepos.isEmpty)
            XCTAssertEqual(receivedRepos.first?.name, repositories.first?.name)
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    // TODO - CRIAR OS DEMAIS CASOS DE FALHA E CONEXAO.

}
