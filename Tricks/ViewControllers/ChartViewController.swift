import UIKit
import TRX

class ChartViewController: UIViewController {
  
  @IBOutlet weak var slider: UISlider!
  private let diameters = 4...9
  private let tweenDuration = 1 as NSTimeInterval
  
  private lazy var circles: [CAShapeLayer] = {
    self.diameters.map { diameter in
      return CircleLayer(
        diameter: CGFloat(diameter) * 20,
        strokeColor: self.colorForDiameter(diameter),
        lineWidth: 10
      )
    }
  }()
  
  private func colorForDiameter(diameter: Int) -> CGColor {
    let ratio = 1 - CGFloat(diameter - diameters.startIndex) / CGFloat(diameters.count)
    return UIColor.trxRed.colorWithAlphaComponent(ratio * 0.9).CGColor
  }
  
  private lazy var timeline: TimeLine = {
    
    let timeline = TimeLine()
    self.circles.enumerate().forEach {
      (index, element) in
      timeline.add(Tween(from: 0,
                         to: 1,
                         time: self.tweenDuration,
                         ease: Quad.easeOut) {
          element.strokeEnd = CGFloat($0)
        }, shift: self.shiftForIndex(index))
    }
    timeline.duration = 1
    return timeline
  }()
  
  private func shiftForIndex(index: Int) -> Double {
    return index == 0 ? 0 : -self.tweenDuration * 0.9
  }

  override func viewDidLoad() {
    for circle in circles {
      view.layer.addSublayer(circle)
      circle.position = self.view.center
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    slider.value = 0
    timeline.seek(0)
  }
  
  override func viewDidAppear(animated: Bool) {
    timeline.start()
  }
  
  @IBAction func valueChanged(sender: UISlider) {
    timeline.seek(NSTimeInterval(sender.value))
  }
  
}
