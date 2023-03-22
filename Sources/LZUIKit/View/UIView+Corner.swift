import UIKit

extension UIView {
    public func cornerLength(_ length:Float) {
        layer.cornerRadius = CGFloat(length)
        layer.masksToBounds = true
    }
}

extension UIView {
    public enum CornerType: Float {
        case none = 0
        case bit =  15
        case small = 5
        case medium = 4
        case large = 3
        case halfCorner = 2
    }
    
    public func cornerType(_ type: CornerType) {
        guard type != .none else {
            layer.cornerRadius = CGFloat(type.rawValue)
            cornerTypeObservation?.invalidate()
            cornerTypeObservation = nil
            return
        }
        
        layer.cornerRadius = min(frame.height, frame.width) / CGFloat(type.rawValue)
        layer.masksToBounds = true
        
        // 監聽 UIView frame 改變，重新計算 cornerRadius
        cornerTypeObservation = observe(\.bounds) { [weak self] _, _ in
            if let weakSelf = self {
                weakSelf.layer.cornerRadius = min(weakSelf.frame.height, weakSelf.frame.width) / CGFloat(type.rawValue)
            }
        }
    }
}

extension UIView {
    public var cornerTypeObservation: NSKeyValueObservation? {
        get {
            let key: StaticString = "UIView+cornerTypeObservation"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? NSKeyValueObservation
        }
        set {
            let key: StaticString = "UIView+cornerTypeObservation"
            if let old = objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? NSKeyValueObservation {
                old.invalidate()
            }
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
