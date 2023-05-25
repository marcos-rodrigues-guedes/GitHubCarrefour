import Foundation

enum UsersDetailsUIState: Equatable {
  case loading
  case success
  case error(String)
}
