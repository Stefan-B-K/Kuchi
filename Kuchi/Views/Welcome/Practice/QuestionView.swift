
import SwiftUI

/// Displays the original word, or question for the practice session.
struct QuestionView: View {
  var question: String
  
  var body: some View {
    Text(question)
      .font(.system(size: 64))
      .allowsTightening(true)
      .foregroundColor(.red)
      .lineLimit(5)
      .multilineTextAlignment(.center)
  }
}

struct QuestionView_Previews: PreviewProvider {
  static var previews: some View {
    QuestionView(question: "口")
  }
}
