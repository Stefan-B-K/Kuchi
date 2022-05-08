
struct Challenge {
  let question: String
  let pronunciation: String
  let answer: String
  var completed: Bool = false
  var succeeded: Bool = false
}

extension Challenge: Hashable {
  func hash(into hasher: inout Hasher) {
    question.hash(into: &hasher)
  }
}
