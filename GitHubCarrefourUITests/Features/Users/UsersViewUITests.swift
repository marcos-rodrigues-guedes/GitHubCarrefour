/*import Foundation

import XCTest

class UsersViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testUsersView_DisplayLoadingState() {
        // Verifica se a view de carregamento está sendo exibida
        XCTAssertTrue(app.progressIndicators["progressView"].exists)
    }

    func testUsersView_DisplayErrorState() {
        // Simula um estado de erro definindo uma variável de ambiente
        app.launchEnvironment["UsersViewUIState"] = "error"
        
        // Verifica se a view de erro está sendo exibida
        XCTAssertTrue(app.alerts["errorView"].exists)
    }

    func testUsersView_DisplayFullListState() {
        // Simula um estado de lista cheia definindo uma variável de ambiente
        app.launchEnvironment["UsersViewUIState"] = "fullList"
        
        // Verifica se a lista de usuários está sendo exibida
        XCTAssertTrue(app.navigationBars["Usuários"].exists)
        XCTAssertEqual(app.tables.cells.count, 2)
    }

    func testUsersView_DisplayEmptyListState() {
        // Simula um estado de lista vazia definindo uma variável de ambiente
        app.launchEnvironment["UsersViewUIState"] = "emptyList"
        
        // Verifica se a view de lista vazia está sendo exibida
        XCTAssertTrue(app.staticTexts["emptyView"].exists)
    }

}
*/
