import Foundation
import SwiftUI
import SnapshotTesting
import XCTest

@testable import GitHubCarrefour

class UsersRowViewSnapshotTests: XCTestCase {
    
    var viewModel: UserRowViewModel!
    var sut: UsersRowView!
    
    override func setUp() {
        super.setUp()
        viewModel = UserRowViewModel(nickName: "carrefour", urlImage: "", url: "")
        sut = UsersRowView(viewModel: viewModel)
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
