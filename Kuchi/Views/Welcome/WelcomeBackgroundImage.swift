
import SwiftUI

struct WelcomeBackgroundImage: View {
  var body: some View {
    Image("welcome-background")
      .resizable()
      .aspectRatio(1 / 1, contentMode: .fill)
      .ignoresSafeArea(.all)
      .saturation(0.5)
      .blur(radius: 5)
      .opacity(0.15)
      .accessibilityHidden(true)
  }
}

struct WelcomeBackgroundImage_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeBackgroundImage()
  }
}
