
import SwiftUI

struct LearnView: View {
  @StateObject private var learnStore = LearningStore(words: ChallengesViewModel.challenges)
  
    var body: some View {
      VStack {
        Spacer()
        Text("Swipe left if you remembered"
             + "\nSwipe right if you didn’t")
        .font(.headline)
        .padding(.bottom)
        DeckView(deck: learnStore.deck, onMemorized: { learnStore.score += 1 })
        Spacer()
        Text("Remembered \(learnStore.score)/\(learnStore.deck.cards.count)")
          .padding(.bottom)
      }
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
