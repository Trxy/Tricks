import UIKit
import TRX

class BasicViewController: UIViewController {
  
  private lazy var circles: Array<CALayer> = {
    (1...7).map {
      CircleLayer(diameter: CGFloat($0) * 10,
                  strokeColor: UIColor.trxGreen.CGColor)
    }
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    circles.forEach {
      self.view.layer.addSublayer($0)
    }
  }
  
  override func viewDidLayoutSubviews() {
    circles.forEach {
      $0.position = self.view.center
    }
  }
  
  @IBAction private func handleTap(recognizer: UIGestureRecognizer) {
    let location = recognizer.locationInView(self.view)
    for i in 0..<circles.count {
      let circle = circles[i]
      Tween(from: circle.position,
            to: location,
            time: 3,
            delay: Double(i) * 0.01,
            ease: Elastic.easeOut,
            key: "circle\(i).move") {
              circle.position = $0
        }.start()
    }
  }
  
}
