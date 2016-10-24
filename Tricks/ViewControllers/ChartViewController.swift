import UIKit
import TRX

class ChartViewController: UIViewController {
  
  @IBOutlet weak var slider: UISlider!
  private let diameters = 4...9
  private let tweenDuration = 1 as TimeInterval
  
  private lazy var circles: [CAShapeLayer] = {
    self.diameters.map { diameter in
      return CircleLayer(
        diameter: CGFloat(diameter) * 20,
        strokeColor: self.colorForDiameter(diameter: diameter),
        lineWidth: 10
      )
    }
  }()
  
  private func colorForDiameter(diameter: Int) -> CGColor {
    let start = diameters.map { $0 } [0]
    let ratio = 1 - CGFloat(diameter - start) / CGFloat(diameters.count)
    return UIColor.trxRed.withAlphaComponent(ratio * 0.9).cgColor
  }
  
  private lazy var timeline: TimeLine = {
    
    let timeline = TimeLine()
    self.circles.enumerated().forEach {
      index, element in
      timeline.add(tween: Tween(from: 0,
                                to: 1,
                                time: self.tweenDuration,
                                ease: Ease.Quad.easeOut) {
                                  element.strokeEnd = $0
      }, shift: self.shiftForIndex(index: index))
    }
    timeline.duration = 1
    return timeline
  }()
  
  private func shiftForIndex(index: Int) -> TimeInterval {
    return index == 0 ? 0 : -self.tweenDuration * 0.9
  }

  override func viewDidLoad() {
    for circle in circles {
      view.layer.addSublayer(circle)
      circle.position = self.view.center
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    slider.value = 0
    timeline.seek(offset: 0)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    timeline.start()
  }
  
  @IBAction func valueChanged(sender: UISlider) {
    timeline.seek(offset: TimeInterval(sender.value))
  }
  
}
