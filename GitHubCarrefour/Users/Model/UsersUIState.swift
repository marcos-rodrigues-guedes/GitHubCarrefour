import Foundation

enum UsersUIState: Equatable {
  case none
  case loading
  case emptyList
  case fullList
  case error(String)
}
