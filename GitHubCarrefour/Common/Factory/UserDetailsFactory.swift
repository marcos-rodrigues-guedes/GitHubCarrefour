import Foundation

extension  UserDetails {
    var toUserDetailsModel: UserDetailsModel {
        UserDetailsModel(login: self.login ?? String(),
                                name: self.name ?? String(),
                                email: self.email ?? String(),
                                location: self.location ?? String(),
                                blog: self.blog ?? String(),
                                twitter: self.twitter ?? String(),
                                company: self.company ?? String(),
                                avatarUrl: self.avatarUrl ?? String(),
                                reposUrl: self.reposUrl ?? String(),
                                followers: self.followers?.description ?? String(),
                                following: self.following?.description ?? String(),
                                created: self.created?.convertDateFormat(oldFormat: FormatDate.formateGlobal.id,
                                                                       newFormat: FormatDate.formateBR.id) ?? String(),
                                updated: self.updated?.convertDateFormat(oldFormat:FormatDate.formateGlobal.id,
                                                                       newFormat: FormatDate.formateBR.id) ?? String(),
                                publicResp: self.publicResp?.description ?? String())
    }
}
