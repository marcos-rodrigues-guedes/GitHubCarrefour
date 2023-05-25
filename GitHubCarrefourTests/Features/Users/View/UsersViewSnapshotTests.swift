import Foundation
import SwiftUI
import SnapshotTesting
import XCTest

@testable import GitHubCarrefour

class UsersViewSnapshotTests: XCTestCase {
    
    var remote: UsersRemoteDataSourceSpy!
    var interactor: UsersInteractorSpy!
    var viewModel: UsersViewModelSpy!
    var sut: UsersView!
    
    override func setUp() {
        super.setUp()
        remote = UsersRemoteDataSourceSpy()
        interactor = UsersInteractorSpy(remote: remote)
        viewModel = UsersViewModelSpy(interactor: interactor)
        sut = UsersView(viewModel: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        viewModel = nil
        remote = nil
        super.tearDown()
    }
    
    func testUsersView_LoadingState() throws {
        // Cria uma instância da UsersView com o estado de loading
        viewModel.uiState = UsersUIState.loading
        
        let view = sut
        
        // Grava um snapshot da view em um arquivo
        assertSnapshot(matching: view.toVC(), as: .image(on: .iPhoneX))
    }

    func testUsersView_SuccessState() throws {
        // Cria uma instância da UsersView com o estado de sucesso
        viewModel.uiState = UsersUIState.fullList
        
        let view = sut
        
        // Grava um snapshot da view em um arquivo
        assertSnapshot(matching: view.toVC(), as: .image(on: .iPhoneX))
    }
    
    func testUsersView_ErrorState() throws {
        // Cria uma instância da UsersView com o estado de erro
        viewModel.uiState = UsersUIState.error("erro desconhecido")
        
        let view = sut
        
        // Grava um snapshot da view em um arquivo
        assertSnapshot(matching: view.toVC(), as: .image(on: .iPhoneX))
    }
    
    func testUsersView_EmptyState() throws {
        // Cria uma instância da UsersView com o estado de lista vazia
        viewModel.uiState = UsersUIState.emptyList
        
        let view = sut
        
        // Grava um snapshot da view em um arquivo
        assertSnapshot(matching: view.toVC(), as: .image(on: .iPhoneX))
    }
}
