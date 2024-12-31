import UIKit

public extension UITableView {
    @discardableResult
    func setBackgroundViewGradientColor(_ colors: [UIColor], direction: CAGradientLayer.Direction = .leftToRight) -> Self {
        self.backgroundViewGradientColor(colors, direction: direction)
        return self
    }

    func backgroundViewGradientColor(_ colors: [UIColor], direction: CAGradientLayer.Direction) {
        backgroundView = UIView(frame: self.bounds)
            .setGradientBackgroundColor(colors, direction: direction)
    }
}
