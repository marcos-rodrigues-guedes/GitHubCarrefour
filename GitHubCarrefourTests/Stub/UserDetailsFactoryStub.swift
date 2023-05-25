import Foundation

@testable import GitHubCarrefour

enum UserDetailsFactoryStub {
    static func makeUserDetail() -> UserDetails {
        UserDetails(id: 0, login: "mojombo", name: "mojombo name", email: "e-mail",
                    location: "Campina Grande PB", blog: "mojombo blog", twitter: "mojombo twitter",
                    company: "mojombo company", avatarUrl: "mojombo avatar", reposUrl: "mojombo repo",
                    followers: 100, following: 0, created: "2007-10-20T05:24:19Z", updated: "2007-10-20T05:24:19Z",
                    publicResp: 0)
    }
    
    static func makeUserRepositoryList() -> [UserRepository] {
        [UserRepository(id: 0, name: "mojombo repo 1", fullName: "new mojombo repo 1 ",
                        isPrivate: false, owner: Owner(id: 0, login: "mojombo"),
                        description: "repo descripton",
                        visibility: "public", created: "2007-10-20T05:24:19Z", updated: "2007-10-20T05:24:19Z"),
         UserRepository(id: 0, name: "defunkt repo 1", fullName: "new defunkt repo 1 ",
                         isPrivate: false, owner: Owner(id: 0, login: "defunkt"),
                         description: "repo descripton",
                         visibility: "public", created: "2000-10-20T05:24:19Z", updated: "2009-10-20T05:24:19Z")]
    }
}
