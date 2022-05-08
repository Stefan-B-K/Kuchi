
import SwiftUI

struct LogoImage: View {
  var body: some View {
    Image(systemName: "table")
      .resizable()
      .frame(width: 30, height: 30)
      .overlay(Circle().stroke(Color.gray, lineWidth: 1))
      .background(Color(white: 0.9))
      .clipShape(Circle())
      .foregroundColor(.red)
      .accessibilityHidden(true)
  }
}

struct LogoView_Previews: PreviewProvider {
  static var previews: some View {
    LogoImage()
  }
}
