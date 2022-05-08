
import SwiftUI

struct ChallengeView: View {
  @Environment(\.verticalSizeClass) var verticalSizeClass
  @AppStorage("numberOfQuestions") private var numberOfQuestions = 5
  @State var showAnswers = false
  @Binding var numberOfAnswered: Int
  let challengeTest: ChallengeTest
  
  @ViewBuilder
  var body: some View {
    if verticalSizeClass == .compact {
      
      VStack {
        HStack {
          Button(action: {
            showAnswers = !showAnswers
          }) {
            QuestionView(
              question: challengeTest.challenge.question)
          }
          if showAnswers {
            Divider()
            ChoicesView(challengeTest: challengeTest)
          }
        }
        ScoreView(
          numberOfAnswered: $numberOfAnswered, numberOfQuestions: numberOfQuestions
        )
      }
    } else {
      VStack {
        Button(action: {
          showAnswers = !showAnswers
        }) {
          QuestionView(
            question: challengeTest.challenge.question)
            .frame(height: 300)
        }
        ScoreView(
          numberOfAnswered: $numberOfAnswered, numberOfQuestions: numberOfQuestions
        )
        if showAnswers {
          Divider()
          ChoicesView(challengeTest: challengeTest)
            .frame(height: 300)
            .padding()
        }
      }
    }
  }
}

struct ChallengeView_Previews: PreviewProvider {
  @State static var numberOfAnswered: Int = 0
  static let challengeTest = ChallengeTest(
    challenge: Challenge(
      question: "おねがい　します",
      pronunciation: "Onegai shimasu",
      answer: "Please"
    ),
    answers: ["Thank you", "Hello", "Goodbye"]
  )
  
  static var previews: some View {
    return ChallengeView(numberOfAnswered: $numberOfAnswered, challengeTest: challengeTest)
  }

}
