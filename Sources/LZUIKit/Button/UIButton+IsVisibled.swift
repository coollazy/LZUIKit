import UIKit

extension UIButton {
    public var visibledBackgroundColor: UIColor {
        get {
            let key: StaticString = "visibledBackgroundColor"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIColor ?? .clear
        }
        set {
            let key: StaticString = "visibledBackgroundColor"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var disabledBackgroundColor: UIColor {
        get {
            let key: StaticString = "disabledBackgroundColor"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIColor ?? .gray
        }
        set {
            let key: StaticString = "disabledBackgroundColor"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var isVisibled: Bool {
        get {
            let key: StaticString = "isVisibled"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? Bool ?? false
        }
        set {
            let key: StaticString = "isVisibled"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            isEnabled = newValue
            backgroundColor = newValue ? visibledBackgroundColor : disabledBackgroundColor
        }
    }
}
