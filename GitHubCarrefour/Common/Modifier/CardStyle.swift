import Foundation
import SwiftUI

struct CardStyle: ViewModifier {
  
    var colorSheme: ColorScheme
    
    init(color: ColorScheme){
        self.colorSheme = color
    }
    
  func body(content: Content) -> some View {
      if colorSheme == .dark {
          content.shadow(color: Color.cyan.opacity(0.2), radius: 5, x: 5, y: 5)
      } else {
          content.shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
      }
  }
}
