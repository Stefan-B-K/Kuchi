
import SwiftUI

struct VerticallyAlignedLabelStyle: LabelStyle {

  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.icon
      configuration.title
    }
  }
}
