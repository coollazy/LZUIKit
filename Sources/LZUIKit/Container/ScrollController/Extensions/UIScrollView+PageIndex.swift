import UIKit

public extension UIScrollView {
    var currenttPageIndex: Int {
        get {
            Int(contentOffset.x / frame.width)
        }
        set {
            contentOffset = CGPoint(x: CGFloat(newValue) * frame.width, y: contentOffset.y)
        }
    }
}
