import SwiftUI
import SnapshotTesting
import XCTest

@testable import GitHubCarrefour

class UserRepositoryRowViewSnapshotTests: XCTestCase {
    
    var viewModel: UserRepositoryRowViewModel!
    var sut: UserRepositoryRowView!
    
    override func setUp() {
        super.setUp()
        viewModel = UserDetailsFactoryStub.makeUserRepositoryList().first?.toUserRepositoryRowModel
        sut = UserRepositoryRowView(viewModel: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testUsersRowView() throws {
        // Cria uma instância da UsersRowView
        let view = sut
        // Grava um snapshot da view em um arquivo
        assertSnapshot(matching: view.toVC(), as: .image(on: .iPhoneX))
    }
}
