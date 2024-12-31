import UIKit

extension UIButton {
    public var isVisibled: Bool {
        get {
            let key: StaticString = "isVisibled"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? Bool ?? false
        }
        set {
            let key: StaticString = "isVisibled"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            isEnabled = newValue
            
            newValue ? onVisibled?(self) : onDisabled?(self)
            
            if let visibledTitleColor = visibledTitleColor, let disabledTitleColor = disabledTitleColor {
                setTitleColor(newValue ? visibledTitleColor : disabledTitleColor, for: .normal)
            }
            
            if let visibledBackgroundColor = visibledBackgroundColor, let disabledBackgroundColor = disabledBackgroundColor {
                backgroundColor = newValue ? visibledBackgroundColor : disabledBackgroundColor
            }
        }
    }
}

extension UIButton {
    public var onVisibled: ((UIButton) -> Void)? {
        get {
            let key: StaticString = "onVisibled"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? ((UIButton) -> Void)
        }
        set {
            let key: StaticString = "onVisibled"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var onDisabled: ((UIButton) -> Void)? {
        get {
            let key: StaticString = "onDisabled"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? ((UIButton) -> Void)
        }
        set {
            let key: StaticString = "onDisabled"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIButton {
    public var visibledTitleColor: UIColor? {
        get {
            let key: StaticString = "visibledTitleColor"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIColor
        }
        set {
            let key: StaticString = "visibledTitleColor"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var disabledTitleColor: UIColor? {
        get {
            let key: StaticString = "disabledTitleColor"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIColor
        }
        set {
            let key: StaticString = "disabledTitleColor"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var visibledBackgroundColor: UIColor? {
        get {
            let key: StaticString = "visibledBackgroundColor"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIColor
        }
        set {
            let key: StaticString = "visibledBackgroundColor"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var disabledBackgroundColor: UIColor? {
        get {
            let key: StaticString = "disabledBackgroundColor"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIColor
        }
        set {
            let key: StaticString = "disabledBackgroundColor"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
