import Foundation
import SwiftUI
import SnapshotTesting
import XCTest

@testable import GitHubCarrefour

class UserRepositoriesListViewSnapshotTests: XCTestCase {
    
    var resps: [UserRepositoryRowViewModel]!
    var sut: UserRepositoriesListView!
    
    override func setUp() {
        super.setUp()
        resps = UserDetailsFactoryStub.makeUserRepositoryList().map { $0.toUserRepositoryRowModel }
        sut = UserRepositoriesListView(listRepositories: resps)
    }
    
    override func tearDown() {
        sut = nil
        resps = nil
        super.tearDown()
    }
    
    func testUsersRowView() throws {
        // Cria uma instância da UsersRowView
        let view = sut
        // Grava um snapshot da view em um arquivo
        assertSnapshot(matching: view.toVC(), as: .image(on: .iPhoneX))
    }
}
