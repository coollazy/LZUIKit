import UIKit

public extension UIWindowScene {
    var loadingLevelWindow: UIWindow {
        UIWindow.toastLevelWindow(windowScene: self)
    }
    
    var alertLevelWindow: UIWindow {
        UIWindow.toastLevelWindow(windowScene: self)
    }
    
    var toastLevelWindow: UIWindow {
        UIWindow.toastLevelWindow(windowScene: self)
    }
}
