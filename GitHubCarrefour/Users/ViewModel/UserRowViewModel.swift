import Foundation
import SwiftUI

struct UserRowViewModel: Identifiable, Equatable {
    var id: Int = 0
    var nickName: String
    var urlImage: String
    var url: String

    static func == (lhs: UserRowViewModel, rhs: UserRowViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension UserRowViewModel {
    func userDetailsView(userDetailsInteractor: UserDetailsInteractorProtocol) -> some View {
        let viewModel = UserDetailsViewModel(userLogin: nickName, interactor: userDetailsInteractor)
        return UserRowRouter.makeUserDetailView(viewModel: viewModel)
    }
}
