import UIKit

extension UIColor {
  
  class var trxGreen: UIColor {
    return UIColor(red: 75 / 255, green: 178 / 255, blue: 157 / 255, alpha: 1)
  }
  
  class var trxRed: UIColor {
    return UIColor(red: 218 / 255, green: 82 / 255, blue: 67 / 255, alpha: 1)
  }
  
  class var trxYellow: UIColor {
    return UIColor(red: 239 / 255, green: 201 / 255, blue: 88 / 255, alpha: 1)
  }
  
  class var trxRandom: UIColor {
    return [trxRed, trxGreen, trxYellow].randomElement()!
  }
  
}
