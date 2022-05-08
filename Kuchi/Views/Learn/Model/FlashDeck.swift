
import Foundation

class FlashDeck: ObservableObject {
  @Published var cards: [FlashCard]
  
  init(from words: [Challenge]) {
    self.cards = words.map {
      FlashCard(word: $0)
    }
  }
}
