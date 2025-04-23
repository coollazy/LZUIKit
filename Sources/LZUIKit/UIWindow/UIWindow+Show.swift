import UIKit

public extension UIWindow {
    func show() {
        isHidden = false
        for windowScene in UIApplication.shared.connectedScenes {
            if windowScene.activationState == UIScene.ActivationState.foregroundActive ||
                windowScene.activationState == UIScene.ActivationState.background {
                self.windowScene = windowScene as? UIWindowScene
                break
            }
        }
        makeKeyAndVisible()
    }
    
    func hide() {
        rootViewController = nil
        isHidden = true
    }
}
