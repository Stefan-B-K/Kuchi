
import SwiftUI

struct ScoreView: View {
  @Binding var numberOfAnswered: Int
  let numberOfQuestions: Int
  
  var body: some View {
    Button {
      numberOfAnswered += 1
    } label: {
      HStack {
        Text("\(numberOfAnswered)/\(numberOfQuestions)")
          .font(.caption)
          .padding(4)
        Spacer()
      }
    }
  }
}

struct ScoreView_Previews: PreviewProvider {
  @State static var numberOfAnswered: Int = 0
  static var previews: some View {
    ScoreView(numberOfAnswered: $numberOfAnswered, numberOfQuestions: 5)
  }
}
