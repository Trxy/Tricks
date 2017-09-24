import UIKit
import TRX

class ParticlesViewController: UIViewController {
  
  struct Arranger {
    let count: Int
    let frame: CGRect
    var center: CGPoint {
      return CGPoint(x: frame.midX,
                     y: frame.midY)
    }
    
    func square(width: CGFloat = 300.0) -> [CGPoint] {
      let rect = frame.insetBy(dx: (frame.width - width) / 2,
                               dy: (frame.height - width) / 2)
      return (0..<count).map { _ in CGPoint.random(rect: rect) }
    }
    
    func wave() -> [CGPoint] {
      let width: CGFloat = 250
      let radius: CGFloat = 20
      return (0..<count).map { i in
        let cgi = CGFloat(i)
        let cgCount = CGFloat(count)
        let x = cgi * width / cgCount + (frame.size.width - width) / 2
        let y = sin((cgi / cgCount) * .pi * 5 ) * radius + frame.size.height / 2
        return CGPoint(x: x, y: y)
      }
    }
    
    func circle(radius: CGFloat = 50) -> [CGPoint] {
      return (0..<count).map { i in
        let angle = CGFloat(i) / CGFloat(count) * .pi * 2
        return CGPoint(x: center.x + cos(angle) * radius,
                       y: center.y + sin(angle) * radius)
      }
    }
  }
  
  private lazy var dots: [CALayer] = {
    return(0...60).map { _ in
      let layer = CircleLayer(
        diameter: 5,
        fillColor: UIColor.trxRandom.cgColor
      )
      self.view.layer.addSublayer(layer)
      layer.position = self.view.center
      return layer
    }
  }()
  
  private lazy var sets: [[CGPoint]] = {
    let arranger = Arranger(count: self.dots.count, frame: self.view.frame)
    return [ arranger.wave(),
             arranger.square(width: 150),
             arranger.square(),
             arranger.circle(),
             arranger.circle(radius: 110),
    ]
  }()
  
  private var currentSet: Int = 0 {
    didSet {
      if currentSet >= sets.count {
        currentSet = 0
      }
      arrange(arrangement: sets[currentSet])
    }
  }
  
  @IBAction func next() {
    currentSet += 1
  }
  
  override func viewDidAppear(_ animated: Bool) {
    next()
  }
  
  private func arrange(arrangement: [CGPoint]) {
    for i in 0..<arrangement.count {
      tweenTo(position: arrangement[i], dot: dots[i])
    }
  }
  
  private func tweenTo(position: CGPoint, dot: CALayer) {
    Tween(from: dot.position,
          to: position,
          time: 1,
          ease: Ease.Quad.easeInOut,
          key: "\(Unmanaged.passUnretained(dot).toOpaque())"
    ) {
      dot.position = $0
    }.start()
  }
}
