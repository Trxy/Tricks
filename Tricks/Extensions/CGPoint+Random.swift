import UIKit

extension CGPoint {
  static func random(rect: CGRect) -> CGPoint {
    return CGPoint(x: Int.random(from: Int(rect.minX), to: Int(rect.maxX)),
                   y: Int.random(from: Int(rect.minY), to: Int(rect.maxY)))
  }
}
