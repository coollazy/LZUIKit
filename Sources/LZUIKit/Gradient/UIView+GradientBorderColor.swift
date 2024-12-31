import UIKit

// Fluent Interface
public extension UIView {
    @discardableResult
    func setGradientBorderColor(_ colors: [UIColor], lineWidth: CGFloat = 2, direction: CAGradientLayer.Direction = .leftToRight) -> Self {
        self.gradientBorderColor(colors, lineWidth: lineWidth, direction: direction)
        return self
    }

    @discardableResult
    func setIsGradientBorderHidden(_ isHidden: Bool) -> Self {
        isGradientBorderHidden = isHidden
        return self
    }
}

// Gradient Border Color
public extension UIView {
    func gradientBorderColor(_ colors: [UIColor], lineWidth: CGFloat, direction: CAGradientLayer.Direction) {
        guard colors.count > 0 else {
            debugPrint("Set UIView gradientBorderColor with empty colors")
            return
        }

        // colors 至少要兩個 如果只有一個的話要變成兩個一樣的
        var cgColors = colors.map({ $0.cgColor })
        if colors.count == 1 {
            cgColors = (colors + colors)
                .map({ $0.cgColor })
        }

        let gradientLayer = gradientBorderLayer ?? CAGradientLayer()
        gradientLayer.setDirection(direction)
        gradientLayer.frame = bounds
        gradientLayer.colors = cgColors
        gradientLayer.zPosition = -1
        gradientBorderLayer = gradientLayer

        if gradientBorderLayer?.mask == nil {
            let shape = CAShapeLayer()
            shape.lineWidth = lineWidth
            shape.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
            shape.strokeColor = UIColor.black.cgColor
            shape.fillColor = UIColor.clear.cgColor
            gradientBorderLayer?.mask = shape
        }

        if gradientLayer.superlayer == nil {
            layer.insertSublayer(gradientLayer, at: 0)
        }

        // 監聽 UIView frame 改變，即時修改 layer 的 frame
        borderObservation = observe(\.bounds) { [weak self] _, _ in
            if let weakSelf = self, let shape = weakSelf.gradientBorderLayer?.mask as? CAShapeLayer {
                shape.path = UIBezierPath(roundedRect: weakSelf.bounds, cornerRadius: weakSelf.layer.cornerRadius).cgPath
                weakSelf.gradientBorderLayer?.frame = weakSelf.bounds
            }
        }
    }

    var isGradientBorderHidden: Bool {
        get {
            gradientBorderLayer?.isHidden ?? false
        }
        set {
            gradientBorderLayer?.isHidden = newValue
        }
    }

    var gradientBorderLayer: CAGradientLayer? {
        get {
            let key: StaticString = "UIView+gradientBorderLayer"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? CAGradientLayer
        }
        set {
            let key: StaticString = "UIView+gradientBorderLayer"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var borderObservation: NSKeyValueObservation? {
        get {
            let key: StaticString = "UIView+borderObservation"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? NSKeyValueObservation
        }
        set {
            let key: StaticString = "UIView+borderObservation"
            if let old = objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? NSKeyValueObservation {
                old.invalidate()
            }
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
