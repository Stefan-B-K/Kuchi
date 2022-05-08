
struct Profile : Codable {
  var name: String
}

extension Profile {
  init() {
    self.name = ""
  }
}
