import UIKit

class CircleLayer: CAShapeLayer {

  init(diameter: CGFloat,
       fillColor: CGColor? = nil,
       strokeColor: CGColor? = nil,
       lineWidth: CGFloat = 2) {
    super.init()
    self.path = UIBezierPath(ovalInRect: square(diameter)).CGPath
    self.fillColor = fillColor
    self.strokeColor = strokeColor
    self.lineWidth = lineWidth
    self.actions = [
      "strokeEnd": NSNull(),
      "strokeStart": NSNull(),
      "position": NSNull(),
    ]
  }
  
  private func square(width: CGFloat) -> CGRect {
    return CGRect(
      x: -width / 2,
      y: -width / 2,
      width: width,
      height: width
    )
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(layer: AnyObject) {
    super.init(layer: layer)
  }
  
}
