import UIKit

public extension UIWindow {
    static var loadingLevelWindow: UIWindow {
        let window = UIWindow()
        window.windowLevel = .alert - 2
        window.frame = UIScreen.main.bounds
        window.backgroundColor = .clear
        window.isHidden = false
        window.isUserInteractionEnabled = true
        return window
    }
    
    static func loadingLevelWindow(windowScene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        window.windowLevel = .alert - 1
        window.frame = UIScreen.main.bounds
        window.backgroundColor = .clear
        window.isHidden = false
        window.isUserInteractionEnabled = true
        return window
    }
}
