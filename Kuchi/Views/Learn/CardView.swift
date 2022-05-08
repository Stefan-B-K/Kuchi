
import SwiftUI

struct CardView: View {
  let flashCard: FlashCard
  @Binding var cardColor: Color
  @State private var showTranslation = false
  @State private var offset: CGSize = .zero
  @GestureState private var isLongPressed = false
  
  enum DragDirection {
    case left, right
  }
  
  typealias CardDrag = (_ card: FlashCard, _ direction: DragDirection) -> Void
  let dragged: CardDrag
  
  func discardCard(to direction: DragDirection) {
    let width: CGFloat
    switch direction {
      case .left: width = -1000
      case .right: width = 1000
    }
    offset = .init(width: width, height: 0)
    dragged(flashCard, direction)
  }
  
  init(_ card: FlashCard, cardColor: Binding<Color>,
       onDrag dragged: @escaping CardDrag = {_,_ in}) {
    flashCard = card
    _cardColor = cardColor
    self.dragged = dragged
  }
  
  var body: some View {
    let drag = DragGesture()
      .onChanged { offset = $0.translation }
      .onEnded {
        if $0.translation.width < -100 {
          offset = .init(width: -1000, height: 0)
          dragged(flashCard, .left)
        } else if $0.translation.width > 100 {
          offset = .init(width: 1000, height: 0)
          dragged(flashCard, .right)
        } else {
          offset = .zero
        }
      }
    let longPress = LongPressGesture()
      .updating($isLongPressed) { value, state, _ in
        state = value
      }
      .simultaneously(with: drag)
    return ZStack {
      Rectangle()
        .fill(cardColor)
        .frame(width: 320, height: 210)
        .cornerRadius(12)
        .shadow(radius: 8)
      VStack {
        Spacer()
        Text(flashCard.word.question)
          .font(.largeTitle)
        if showTranslation {
          Text(flashCard.word.answer)
            .font(.caption)
        }
        Spacer()
      }
      .foregroundColor(.white)
    }
    .frame(width: 320, height: 210)
    .offset(offset)
    .gesture(longPress)
    .scaleEffect(isLongPressed ? 1.1 : 1.0)
    .animation(.easeInOut(duration: 0.3), value: isLongPressed)
    .simultaneousGesture(TapGesture().onEnded {
      withAnimation(.easeIn) { showTranslation.toggle() }
    })
    .animation(.easeIn, value: offset)
  }
  
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(FlashCard(word: Challenge(question: "こんにちわ",
                                       pronunciation: "Konnichiwa",
                                       answer: "Hello")), cardColor: .constant(.red))
  }
}
