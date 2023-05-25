import XCTest
import Combine

@testable import GitHubCarrefour

class UsersViewModelTests: XCTestCase {
    var sut: UsersViewModel!
    var interactorSpy: UsersInteractorSpy!
    
    override func setUp() {
        super.setUp()
        interactorSpy = UsersInteractorSpy(remote: UsersRemoteDataSourceSpy())
        sut = UsersViewModel(interactor: interactorSpy)
    }
    
    override func tearDown() {
        sut = nil
        interactorSpy = nil
        super.tearDown()
    }
    
    func testOnAppear_Success() throws {
        // Cria um exemplo de lista de usuários
        let users = UserListFactoryStub.makeUserRowViewModelList()
        
        // Define o comportamento esperado para a chamada de interactor
        
        interactorSpy.getGitHubUsersClosure = {
            return Just(users)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        // Chame o método sendo testado
        sut.onAppear()
        
        // Aguarde o retorno da closure
        let expectation = XCTestExpectation(description: "Wait for getGitHubUsersClosure")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.3)
        
        // Verifique se o estado UI foi atualizado corretamente
        XCTAssertEqual(sut.uiState, UsersUIState.fullList)
        XCTAssertEqual(sut.searchResults.count, 2)
        XCTAssertEqual(sut.searchResults[0].nickName, "mojombo")
        XCTAssertEqual(sut.searchResults[1].nickName, "defunkt")
    }
    
    func testOnAppear_EmptyList() {
        // Defina o comportamento esperado para a chamada de interactor
        interactorSpy.getGitHubUsersClosure = {
            return Just([UserRowViewModel]())
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        // Chame o método sendo testado
        sut.onAppear()
        
        // Aguarde o retorno da closure
        let expectation = XCTestExpectation(description: "Wait for getGitHubUsersClosure")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.5)
        
        // Verifique se o estado UI foi atualizado corretamente
        XCTAssertEqual(sut.uiState, UsersUIState.emptyList)
        XCTAssertEqual(sut.searchResults.count, 0)
    }
    
    func testOnAppear_Failure() {
        // Crie um exemplo de erro
        let error = NetworkError.connectionError("erro de conexão")
        
        // Defina o comportamento esperado para a chamada de interactor
        interactorSpy.getGitHubUsersClosure = {
            return Fail<[UserRowViewModel], NetworkError>(error: error)
                .eraseToAnyPublisher()
        }
        
        // Chame o método sendo testado
        sut.onAppear()
        
        // Aguarde o retorno da closure
        let expectation = XCTestExpectation(description: "Wait for getGitHubUsersClosure")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.3)
        
        // Verifique se o estado UI foi atualizado corretamente
        XCTAssertEqual(sut.uiState, UsersUIState.error(error.errorDescription))
        XCTAssertEqual(sut.searchResults.count, 0)
    }
    
    func testSearchResults_NoSearchText() {
        // Crie um exemplo de lista de usuários
        let users = UserListFactoryStub.makeUserList()
        
        // Defina a lista de usuários no ViewModel
        sut.usersList = users.map {
            return UserRowViewModel(id: $0.id,
                                    nickName: $0.login,
                                    urlImage: $0.avatarUrl,
                                    url: $0.url)
        }
        
        // Defina um texto de pesquisa vazio
        sut.searchText = ""
        
        // Verifique se os resultados de pesquisa são iguais à lista de usuários original
        XCTAssertEqual(sut.searchResults.count, 2)
        XCTAssertEqual(sut.searchResults[0].nickName, "mojombo")
        XCTAssertEqual(sut.searchResults[1].nickName, "defunkt")
    }
    
    func testSearchResults_WithSearchText() {
        // Crie um exemplo de lista de usuários
        let users = UserListFactoryStub.makeUserList()
        
        // Defina a lista de usuários no ViewModel
        sut.usersList = users.map {
            return UserRowViewModel(id: $0.id,
                                    nickName: $0.login,
                                    urlImage: $0.avatarUrl,
                                    url: $0.url)
        }
        
        // Defina um texto de pesquisa
        sut.searchText = "m"
        
        // Verifique se os resultados de pesquisa contêm apenas usuários cujo nickName contenha o texto de pesquisa
        XCTAssertEqual(sut.searchResults.count, 1)
        XCTAssertEqual(sut.searchResults[0].nickName, "mojombo")
        //XCTAssertEqual(sut.searchResults[1].nickName, "Jane")
    }
    
    
    
    func testSearchResults_WithSearchText_NoMatchingUsers() {
        // Crie um exemplo de lista de usuários
        let users = UserListFactoryStub.makeUserList()
        
        // Defina a lista de usuários no ViewModel
        sut.usersList = users.map {
            return UserRowViewModel(id: $0.id,
                                    nickName: $0.login,
                                    urlImage: $0.avatarUrl,
                                    url: $0.url)
        }
        
        // Defina um texto de pesquisa que não corresponda a nenhum usuário
        sut.searchText = "xyz"
        
        // Verifique se os resultados de pesquisa estão vazios
        XCTAssertEqual(sut.searchResults.count, 0)
    }
    
    func testSearchResults_CaseInsensitiveSearch() {
        // Crie um exemplo de lista de usuários
        let users = UserListFactoryStub.makeUserList()
        
        // Defina a lista de usuários no ViewModel
        sut.usersList = users.map {
            return UserRowViewModel(id: $0.id,
                                    nickName: $0.login,
                                    urlImage: $0.avatarUrl,
                                    url: $0.url)
        }
        
        // Defina um texto de pesquisa em maiúsculas
        sut.searchText = "MOJOMBO"
        
        // Verifique se os resultados de pesquisa contêm o usuário com o nickName correspondente, ignorando o caso
        XCTAssertEqual(sut.searchResults.count, 1)
        XCTAssertEqual(sut.searchResults[0].nickName, "mojombo")
    }
}
