import SwiftUI

@main
struct GitHubCarrefourApp: App {
    var body: some Scene {
        WindowGroup {
            UsersView(viewModel: UsersViewModel(interactor: UsersInteractor()))
        }
    }
}
