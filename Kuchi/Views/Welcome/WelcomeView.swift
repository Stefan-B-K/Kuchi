
import SwiftUI

struct WelcomeView: View {
  @EnvironmentObject var userManager: UserManager
  @EnvironmentObject var challengesViewModel: ChallengesViewModel
  @AppStorage("learningEnabled")  private var learningEnabled: Bool = true
  @State var showPractice = false
  @State private var selectedTab = 0
  
  var body: some View {
    
    if showPractice {
      TabView(selection: $selectedTab) {
        if learningEnabled {
          LearnView()
            .tabItem {
              VStack {
                Image(systemName: "bookmark")
                Text("Learn")
              }
            }
            .tag(0)
        }
        
        PracticeView(challengeTest: $challengesViewModel.currentChallenge,
                     userName: $userManager.profile.name,
                     numberOfAnswered: .constant(challengesViewModel.numberOfAnswered))
          .tabItem {
            VStack {
              Image(systemName: "rectangle.dock")
              Text("Challanges")
            }
          }
          .tag(1)
        
        SettingsView()
          .tabItem {
            VStack {
              Image(systemName: "gear")
              Text("Settings")
            }
          }
          .tag(2)
      }
      .tint(.accentColor)
      .padding(.bottom, 5)
      
    } else {
      ZStack {
        WelcomeBackgroundImage()
        VStack {
          Text(verbatim: "Hi, \(userManager.profile.name)")
          WelcomeMessageView()
          Button {
            showPractice = true
          } label: {
            HStack {
              Image(systemName: "play")
              Text("Start")
            }
          }
        }
      }
    }
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
      .environmentObject(UserManager(name: "John Doe"))
  }
}
