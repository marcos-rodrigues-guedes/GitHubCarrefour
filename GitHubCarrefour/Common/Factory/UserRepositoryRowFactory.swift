import Foundation

extension UserRepository {
    var toUserRepositoryRowModel: UserRepositoryRowViewModel {
        UserRepositoryRowViewModel(id: self.id ?? 0,
                                          name: self.name ?? String(),
                                          fullName: self.fullName ?? String(),
                                          description: self.description ?? String(),
                                          visibility: self.visibility ?? String(),
                                          created: self.created.convertDateFormat(oldFormat: FormatDate.formateGlobal.id,
                                                                                newFormat: FormatDate.formateBR.id),
                                          updated: self.updated.convertDateFormat(oldFormat: FormatDate.formateGlobal.id,
                                                                                newFormat: FormatDate.formateBR.id) )
    }
}
