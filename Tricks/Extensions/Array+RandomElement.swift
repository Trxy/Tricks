import Foundation

extension Array {
  
  func randomElement() -> Generator.Element? {
    guard count > 0 else {
      return nil
    }
    return self[Int.random(0, to: count - 1)]
  }
}