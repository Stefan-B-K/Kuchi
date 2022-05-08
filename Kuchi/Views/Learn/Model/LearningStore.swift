
import Foundation

class LearningStore: ObservableObject {
  @Published var deck: FlashDeck
  @Published var card: FlashCard?
  @Published var score = 0
  
  init(words: [Challenge]) {
    self.deck = FlashDeck(from: words)
    self.card = deck.cards.popLast()
  }
}





