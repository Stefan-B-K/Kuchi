
import Foundation

struct FlashCard: Identifiable {
  var word: Challenge
  var isActive = true
  var id = UUID()
}

extension FlashCard: Equatable {
  static func == (lhs: FlashCard, rhs: FlashCard) -> Bool {
    return lhs.word.question == rhs.word.question &&
    lhs.word.answer == rhs.word.answer
  }
}
