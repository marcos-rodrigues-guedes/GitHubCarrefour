import Foundation
import SwiftUI

struct AlertErrorView: View {
    var action: () -> Void
    var msg: String
    var body: some View {
        ZStack {
            Text("")
                .alert(isPresented: .constant(true)) {
                    Alert(
                        title: Text("Ops! \(msg)"),
                        message: Text("Tentar novamente?"),
                        primaryButton: .default(Text("Sim")) {
                            action()
                        },
                        secondaryButton: .cancel()
                    )
                }
        }
    }
}
