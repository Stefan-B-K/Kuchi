
import SwiftUI

struct RegisterView: View {
  
  @EnvironmentObject var userManager: UserManager
  @FocusState var nameFieldFocused: Bool
  
  var body: some View {
    VStack(alignment: .center) {
      
      Spacer()
      
      WelcomeMessageView()
      
      TextField("Enter your name", text: $userManager.profile.name)
        .focused($nameFieldFocused)
        .border()
        .padding(.horizontal)
        .frame(maxWidth: 400)
        .submitLabel(.done)
        .onSubmit {
          registerUser()
        }
      
      HStack {
        Spacer()
        Text("\(userManager.profile.name.count)")
          .accessibilityLabel("name has \(userManager.profile.name.count) letters")
          .accessibilityHint("name needs 3 or more letters to enable OK button")
          .font(.caption)
          .foregroundColor(userManager.isUserNameValid() ? .init(red: 0.2, green: 0.8, blue: 0.2) : .red)
          .padding(.trailing, 30)
      }
      .frame(maxWidth: 400)
      .padding(.bottom)
      
      HStack {
        Spacer()
        Toggle(isOn: $userManager.settings.rememberUser) {
          HStack {
            Spacer()
            Text("Remember me")
              .font(.subheadline)
              .foregroundColor(.gray)
          }
        }
        .padding(.trailing, 10)
      }
      .frame(maxWidth: 400)
      .padding(.trailing, 10)
      
      Button(action: registerUser) {
        HStack {
          Image(systemName: "checkmark")
            .resizable()
            .frame(width: 16, height: 16, alignment: .center)
          Text("OK")
            .font(.body)
            .bold()
        }
        .border()
        .disabled(!userManager.isUserNameValid())
      }
      .accessibilityLabel("OK registers user")
      .accessibilityHint("name needs 3 or more letters to enable OK button")
      .accessibilityValue(userManager.isUserNameValid() ? "enabled" : "disabled")

      .padding()
      
      Spacer()
      
    }
    .background(WelcomeBackgroundImage())
    .onAppear {
      nameFieldFocused = true
    }
  }
}

struct RegisterView_Previews: PreviewProvider {
  static let user = UserManager(name: "Stefan")
  
  static var previews: some View {
    RegisterView()
      .environmentObject(user)
      .previewInterfaceOrientation(.portraitUpsideDown)
  }
}


extension RegisterView {
  func registerUser() {
    nameFieldFocused = false
    
    if userManager.settings.rememberUser {
      userManager.persistProfile()
    } else {
      userManager.clear()
    }
    userManager.persistSettings()
    userManager.setRegistered()
  }
  
}
