
struct ChallengeTest {
  let challenge: Challenge
  let answers: [String]
  func isAnswerCorrect(_ answer: String) -> Bool {
    return challenge.answer == answer
  }
}
