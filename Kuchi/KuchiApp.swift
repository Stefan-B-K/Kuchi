
import SwiftUI

@main
struct KuchiApp: App {
 let userManager = UserManager()
 let challengesViewModel = ChallengesViewModel()
  
 @AppStorage("apperance") private var apperance: Appearance = .automatic
  
  var body: some Scene {
    WindowGroup {
      StarterView()
        .environmentObject(userManager)
        .environmentObject(challengesViewModel)
        .preferredColorScheme(apperance.getColorScheme())
    }
  }
  
  init() {
    userManager.load()
  }
}

struct KuchiApp_Previews: PreviewProvider {
  static let userManager = UserManager()
  static let challengesViewModel = ChallengesViewModel()
  
  static var previews: some View {
    StarterView()
      .environmentObject(userManager)
      .environmentObject(ChallengesViewModel())
  }
}
