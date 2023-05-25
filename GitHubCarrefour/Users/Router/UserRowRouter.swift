import Foundation
import SwiftUI

enum UserRowRouter {
    static func makeUserDetailView(viewModel: UserDetailsViewModel) -> some View {
        return DetalisView(viewModel: viewModel)
    }
}
