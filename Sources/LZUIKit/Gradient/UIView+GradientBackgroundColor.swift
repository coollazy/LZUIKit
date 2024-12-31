import UIKit

// Fluent Interface
public extension UIView {
    @discardableResult
    func setGradientBackgroundColor(_ colors: [UIColor], direction: CAGradientLayer.Direction = .leftToRight) -> Self {
        self.gradientBackgroundColor(colors, direction: direction)
        return self
    }
}

// Gradient Background Color
public extension UIView {
    func gradientBackgroundColor(_ colors: [UIColor], direction: CAGradientLayer.Direction) {
        guard colors.count > 0 else {
            debugPrint("Set UIView gradientBackgroundColor with empty colors")
            return
        }

        // colors 至少要兩個 如果只有一個的話要變成兩個一樣的
        var cgColors = colors.map({ $0.cgColor })
        if colors.count == 1 {
            cgColors = (colors + colors)
                .map({ $0.cgColor })
        }

        gradientBackgroundLayer?.removeFromSuperlayer()
        gradientBackgroundLayer = nil
        let gradientLayer = CAGradientLayer()
        gradientLayer.setDirection(direction)
        gradientLayer.frame = bounds
        gradientLayer.colors = cgColors
        gradientLayer.zPosition = -2
        layer.insertSublayer(gradientLayer, at: 0)
        gradientBackgroundLayer = gradientLayer

        // 監聽 UIView frame 改變，即時修改 layer 的 frame
        backgroundObservation?.invalidate()
        backgroundObservation = nil
        backgroundObservation = observe(\.bounds) { [weak self] _, _ in
            if let weakSelf = self {
                weakSelf.gradientBackgroundLayer?.frame = weakSelf.bounds
            }
        }
    }

    var gradientBackgroundLayer: CAGradientLayer? {
        get {
            let key: StaticString = "UIView+gradientBackgroundLayer"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? CAGradientLayer
        }
        set {
            let key: StaticString = "UIView+gradientBackgroundLayer"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var backgroundObservation: NSKeyValueObservation? {
        get {
            let key: StaticString = "UIView+backgroundObservation"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? NSKeyValueObservation
        }
        set {
            let key: StaticString = "UIView+backgroundObservation"
            if let old = objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? NSKeyValueObservation {
                old.invalidate()
            }
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
