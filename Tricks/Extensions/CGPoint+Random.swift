import UIKit

extension CGPoint {
  static func random(rect: CGRect) -> CGPoint {
    return CGPoint(x: Int.random(Int(CGRectGetMinX(rect)), to: Int(CGRectGetMaxX(rect))),
                   y: Int.random(Int(CGRectGetMinY(rect)), to: Int(CGRectGetMaxY(rect))))
  }
}