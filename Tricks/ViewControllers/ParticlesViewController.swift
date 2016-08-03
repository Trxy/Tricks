import UIKit
import TRX

class ParticlesViewController: UIViewController {

  struct Arranger {
    private let count: Int
    private let frame: CGRect
    private var center: CGPoint {
      return CGPoint(x: CGRectGetMidX(frame),
                     y: CGRectGetMidY(frame))
    }
    
    func square(width: CGFloat = 300.0) -> [CGPoint] {
      let rect = CGRectInset(frame,
                             (frame.width - width) / 2,
                             (frame.height - width) / 2)
      return (0..<count).map { _ in CGPoint.random(rect) }
    }
    
    func wave() -> [CGPoint] {
      let width: CGFloat = 250
      let radius: CGFloat = 20
      return (0..<count).map { i in
        return CGPoint(
          x: CGFloat(i) * width / CGFloat(count) + (frame.size.width - width) / 2,
          y: sin( (CGFloat(i) / CGFloat(count)) * CGFloat(M_PI) * 5 ) * radius + frame.size.height / 2)
      }
    }
    
    func circle(radius: CGFloat = 50) -> [CGPoint] {
      return (0..<count).map { i in
        let angle = CGFloat(i) / CGFloat(count) * CGFloat(M_PI * 2)
        return CGPoint(x: center.x + cos(angle) * radius,
                       y: center.y + sin(angle) * radius)
      }
    }
  }
  
  private lazy var dots: [CALayer] = {
    return(0...60).map { _ in
      let layer = CircleLayer(
        diameter: 5,
        fillColor: UIColor.trxRandom.CGColor
      )
      self.view.layer.addSublayer(layer)
      layer.position = self.view.center
      return layer
    }
  }()
  
  private lazy var sets: [[CGPoint]] = {
    let arranger = Arranger(count: self.dots.count, frame: self.view.frame)
    return [ arranger.wave(),
             arranger.square(150),
             arranger.square(),
             arranger.circle(),
             arranger.circle(110),
    ]
  }()
  
  
  private var currentSet: Int = 0 {
    didSet {
      if currentSet >= sets.count {
        currentSet = 0
      }
      arrange(sets[currentSet])
    }
  }
  
  @IBAction func next() {
    currentSet += 1
  }
  
  override func viewDidAppear(animated: Bool) {
    next()
  }
  
  private func arrange(arrangement: [CGPoint]) {
    for i in 0..<arrangement.count {
      tweenTo(arrangement[i], dot: dots[i])
    }
  }
  
  private func tweenTo(position: CGPoint, dot: CALayer) {
    Tween(from: dot.position,
          to: position,
          time: 1,
          ease: Ease.Quad.easeInOut,
          key: "\(unsafeAddressOf(dot))"
    ) {
      dot.position = $0
    }.start()
  }
}
