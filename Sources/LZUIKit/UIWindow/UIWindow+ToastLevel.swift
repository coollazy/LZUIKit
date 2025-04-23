import UIKit

public extension UIWindow {
    static var toastLevelWindow: UIWindow {
        let window = UIWindow()
        window.windowLevel = .alert + 2
        window.frame = UIScreen.main.bounds
        window.backgroundColor = .clear
        window.isHidden = false
        window.isUserInteractionEnabled = false
        return window
    }
}
