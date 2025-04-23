import UIKit

public extension UIWindow {
    static var alertLevelWindow: UIWindow {
        let window = UIWindow()
        window.windowLevel = .alert
        window.frame = UIScreen.main.bounds
        window.backgroundColor = .clear
        window.isHidden = false
        window.isUserInteractionEnabled = true
        return window
    }
}
