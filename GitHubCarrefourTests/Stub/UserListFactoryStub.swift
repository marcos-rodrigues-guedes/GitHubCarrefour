import Foundation

@testable import GitHubCarrefour

enum UserListFactoryStub {
    
    static func makeUserList() -> [User] {
        [User(id: 1,
              login: "mojombo",
              url: "https://api.github.com/users/mojombo",
              avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4"),
         User(id: 2,
              login: "defunkt",
              url: "https://api.github.com/users/defunkt",
              avatarUrl: "https://avatars.githubusercontent.com/u/2?v=4")]
    }
    
    static func makeUserRowViewModelList() -> [UserRowViewModel] {
        [UserRowViewModel(id: 1, nickName: "mojombo", urlImage: "https://avatars.githubusercontent.com/u/1?v=4", url: "https://api.github.com/users/mojombo"),
         UserRowViewModel(id: 2, nickName: "defunkt", urlImage: "https://avatars.githubusercontent.com/u/2?v=4", url: "https://api.github.com/users/defunkt")]
    }
}
