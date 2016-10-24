import Foundation

extension Array {
  
  func randomElement() -> Element? {
    guard count > 0 else {
      return nil
    }
    return self[Int.random(from: 0, to: count - 1)]
  }
}
