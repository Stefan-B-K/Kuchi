
import SwiftUI

struct BorderedViewModifier: ViewModifier {
  
  func body(content: Content) -> some View {
    content
    .padding(
      EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
    )
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 8))
    .overlay(
      RoundedRectangle(cornerRadius: 8)
        .stroke(Color.blue, lineWidth: 2)
    )
    .shadow(color: .gray.opacity(0.4),
            radius: 3, x: 1, y: 2)
  }
  
}

extension View {
  func border() -> some View {
    self.modifier(BorderedViewModifier())
  }
}


