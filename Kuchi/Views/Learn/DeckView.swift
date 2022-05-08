
import SwiftUI

struct DeckView: View {
  @ObservedObject private var deck: FlashDeck
  @AppStorage("cardBackgroundColor") var cardBackgroundColorShadow: Int = 0xFF0000FF
  let onMemorized: () -> Void
  
  var body: some View {
    ZStack {
      ForEach(deck.cards.filter { $0.isActive }) { card in
        getCardView(for: card)
      }
    }
  }
  
  init(deck: FlashDeck, onMemorized: @escaping () -> Void) {
    self.onMemorized = onMemorized
    self.deck = deck
  }
  
  func getCardView(for card: FlashCard) -> CardView {
    let activeCards = deck.cards.filter { $0.isActive == true }
    if let lastCard = activeCards.last, lastCard == card {
        return createCardView(for: card)
    }
    let view = createCardView(for: card)
    return view
  }
  
  private func createCardView(for card: FlashCard) -> CardView{
    let view = CardView(card,
                        cardColor: Binding(get: { Color(rgba: cardBackgroundColorShadow) },
                                           set: { newValue in cardBackgroundColorShadow = newValue.asRgba } ),
                        onDrag: { _, direction in if direction == .left { onMemorized() } }
    )
    return view
  }
  
}

struct DeckView_Previews: PreviewProvider {
  static var previews: some View {
    DeckView(deck: FlashDeck(from: ChallengesViewModel.challenges), onMemorized: {})
  }
}
