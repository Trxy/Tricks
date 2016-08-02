import Foundation

extension Int {
  static func random(from: Int, to:Int) -> Int {
    return from + Int(arc4random_uniform(UInt32(to - from + 1)))
  }
}