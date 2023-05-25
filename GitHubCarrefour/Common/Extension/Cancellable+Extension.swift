import Foundation
import Combine

typealias DisposeBag = Set<AnyCancellable>

extension DisposeBag {
    mutating func dispose() {
        forEach { $0.cancel() }
        removeAll()
    }
}
