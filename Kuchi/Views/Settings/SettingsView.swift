//

import SwiftUI

struct SettingsView: View {
  @AppStorage("numberOfQuestions") private var numberOfQuestions = 5
  @AppStorage("apperance") private var apperance: Appearance = .automatic
  
  @AppStorage("dailyReminderTime") private var dailyReminderTimeShadow: Double = 0
  @State private var dailyReminderTime = Date(timeIntervalSince1970: 0)
  
  @AppStorage("dailyReminderEnabled") private var dailyReminderEnabled: Bool = false
  @AppStorage("learningEnabled")  private var learningEnabled: Bool = true
  
  @AppStorage("cardBackgroundColor") var cardBackgroundColorShadow: Int = 0xFF0000FF
  @State private var cardBackgroundColor: Color = .red
  
  var body: some View {
    List {
      Text("Settings")
        .font(.largeTitle)
        .padding(.bottom, 8)
      Section("Appearance") {
        VStack {
          Picker("", selection: $apperance) {
            ForEach(Appearance.allCases) { appearance in
              Text(appearance.name).tag(appearance)
            }
          }
          .pickerStyle(.segmented)
          ColorPicker("Card Background Color", selection: $cardBackgroundColor)
        }
      }
      Section("Game") {
        VStack(alignment: .leading) {
          Stepper("Number of Questions: \(numberOfQuestions)", value: $numberOfQuestions, in: 3...20)
          Text("Any change will affect the next game")
            .font(.caption2)
            .foregroundColor(.secondary)
          Toggle("Learning enabled", isOn: $learningEnabled)
        }
      }
      Section("Notifications") {
        HStack {
          Toggle(isOn: $dailyReminderEnabled) {
            Text("Daily Reminder")
              .lineLimit(1)
          }
          .layoutPriority(1)
          if dailyReminderEnabled {
            DatePicker("", selection: $dailyReminderTime,
                       displayedComponents: .hourAndMinute)
          }
        }
        .frame(height: 30)
        .animation(Animation.default, value: dailyReminderEnabled)
        .onChange(of: dailyReminderEnabled) { _ in configureNotification() }
        .onChange(of: dailyReminderTime) { newValue in
          dailyReminderTimeShadow = newValue.timeIntervalSince1970
          configureNotification() }
        .onChange(of: cardBackgroundColor, perform: { newValue in
          cardBackgroundColorShadow = newValue.asRgba
        })
        .onAppear() {
          dailyReminderTime = Date(timeIntervalSince1970: dailyReminderTimeShadow)
          cardBackgroundColor = Color(rgba: cardBackgroundColorShadow)
        }
      }
    }
  }
  
  func configureNotification() {
    if dailyReminderEnabled {
      LocalNotifications.shared.createReminder(time: dailyReminderTime)
    } else {
      LocalNotifications.shared.deleteReminder()
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
