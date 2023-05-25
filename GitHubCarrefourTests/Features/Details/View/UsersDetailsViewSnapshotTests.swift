import Foundation
import SwiftUI
import SnapshotTesting
import XCTest

@testable import GitHubCarrefour

class UsersDetailsViewSnapshotTests: XCTestCase {
    var remote: UserDetailsRemoteDataSourceSpy!
    var interactor: UserDetailsInteractorSpy!
    var viewModel: UserDetailsViewModel!
    var sut: DetalisView!
    
    override func setUp() {
        super.setUp()
        remote = UserDetailsRemoteDataSourceSpy()
        interactor = UserDetailsInteractorSpy(remote: remote)
        viewModel = UserDetailsViewModel(userLogin: String(), interactor: interactor)
        sut = DetalisView(viewModel: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        viewModel = nil
        remote = nil
        super.tearDown()
    }
    
    func testUsersView_SuccessState() throws {
        // Cria uma instância da DetalisView com o estado de sucesso
        viewModel.uiState = UsersDetailsUIState.success
        
        let view = sut
        
        // Grava um snapshot da view em um arquivo
        assertSnapshot(matching: view.toVC(), as: .image(on: .iPhoneX))
    }
    
    func testUsersView_ErrorState() throws {
        // Cria uma instância da DetalisView com o estado de erro
        viewModel.uiState = UsersDetailsUIState.error("erro desconhecido")
        
        let view = sut
        
        // Grava um snapshot da view em um arquivo
        assertSnapshot(matching: view.toVC(), as: .image(on: .iPhoneX))
    }
    
    func testUsersView_LoadingState() throws {
        // Cria uma instância da DetalisView com o estado de lista vazia
        viewModel.uiState = UsersDetailsUIState.loading
        
        let view = sut
        
        // Grava um snapshot da view em um arquivo
        assertSnapshot(matching: view.toVC(), as: .image(on: .iPhoneX))
    }
    
}
