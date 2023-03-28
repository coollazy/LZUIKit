import UIKit

extension UITextField {
    // 在 AppDelegate 呼叫 UITextField.enableContentInset() 開啟這個功能
    public static func enableContentInset() {
        _ = swizzleTextRect
        _ = swizzleEditingRect
        _ = swizzleLeftViewRect
        _ = swizzleRightViewRect
        _ = swizzleClearButtonRect
    }
}

extension UITextField {
    // 設定 contentInset 可以讓 UITextField 內容都內縮(包含 leftView 跟 rightView)
    public var contentInset: UIEdgeInsets {
        get {
            let key: StaticString = "UITextField+contentInset"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIEdgeInsets ?? .zero
        }
        set {
            let key: StaticString = "UITextField+contentInset"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // 設定 textContentInset 可以讓文字內縮
    public var textContentInset: UIEdgeInsets {
        get {
            let key: StaticString = "UITextField+textContentInset"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIEdgeInsets ?? .zero
        }
        set {
            let key: StaticString = "UITextField+textContentInset"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// 支援 Fluent interface
extension UITextField {
    @discardableResult
    public func setContentInset(inset: UIEdgeInsets) -> Self {
        contentInset = inset
        return self
    }

    @discardableResult
    public func setTextContentInset(inset: UIEdgeInsets) -> Self {
        textContentInset = inset
        return self
    }
}

extension UITextField {
    @objc private func contentInset_textRect(forBounds bounds: CGRect) -> CGRect {
        contentInset_textRect(forBounds: bounds)
            .inset(by: textContentInset)
            .inset(by: .init(top: 0, left: 0, bottom: 0, right: contentInset.right))
            .inset(by: .init(top: contentInset.top, left: 0, bottom: -contentInset.top, right: 0))
            .inset(by: .init(top: -contentInset.bottom, left: 0, bottom: contentInset.bottom, right: 0))
    }

    private static var swizzleTextRect: Void = {
        let aClass: AnyClass! = object_getClass(UITextField())
        let originalMethod = class_getInstanceMethod(aClass, #selector(textRect(forBounds:)))
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(contentInset_textRect(forBounds:)))
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        else {
            debugPrint("UITextField swizzleTextRect failed")
        }
    }()
}

extension UITextField {
    @objc private func contentInset_editingRect(forBounds bounds: CGRect) -> CGRect {
        contentInset_editingRect(forBounds: bounds)
            .inset(by: textContentInset)
            .inset(by: .init(top: 0, left: 0, bottom: 0, right: contentInset.right))
            .inset(by: .init(top: contentInset.top, left: 0, bottom: -contentInset.top, right: 0))
            .inset(by: .init(top: -contentInset.bottom, left: 0, bottom: contentInset.bottom, right: 0))
    }

    private static var swizzleEditingRect: Void = {
        let aClass: AnyClass! = object_getClass(UITextField())
        let originalMethod = class_getInstanceMethod(aClass, #selector(editingRect(forBounds:)))
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(contentInset_editingRect(forBounds:)))
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        else {
            debugPrint("UITextField swizzleEditingRect failed")
        }
    }()
}

extension UITextField {
    @objc private func contentInset_leftViewRect(forBounds bounds: CGRect) -> CGRect {
        contentInset_leftViewRect(forBounds: bounds)
            .inset(by: .init(top: 0, left: contentInset.left, bottom: 0, right: -contentInset.left))
            .inset(by: .init(top: contentInset.top, left: 0, bottom: -contentInset.top, right: 0))
            .inset(by: .init(top: -contentInset.bottom, left: 0, bottom: contentInset.bottom, right: 0))
    }

    private static var swizzleLeftViewRect: Void = {
        let aClass: AnyClass! = object_getClass(UITextField())
        let originalMethod = class_getInstanceMethod(aClass, #selector(leftViewRect(forBounds:)))
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(contentInset_leftViewRect(forBounds:)))
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        else {
            debugPrint("UITextField swizzleLeftViewRect failed")
        }
    }()
}

extension UITextField {
    @objc private func contentInset_rightViewRect(forBounds bounds: CGRect) -> CGRect {
        contentInset_rightViewRect(forBounds: bounds)
            .inset(by: .init(top: 0, left: -contentInset.right, bottom: 0, right: contentInset.right))
            .inset(by: .init(top: contentInset.top, left: 0, bottom: -contentInset.top, right: 0))
            .inset(by: .init(top: -contentInset.bottom, left: 0, bottom: contentInset.bottom, right: 0))
    }

    private static var swizzleRightViewRect: Void = {
        let aClass: AnyClass! = object_getClass(UITextField())
        let originalMethod = class_getInstanceMethod(aClass, #selector(rightViewRect(forBounds:)))
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(contentInset_rightViewRect(forBounds:)))
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        else {
            debugPrint("UITextField swizzleRightViewRect failed")
        }
    }()
}

extension UITextField {
    @objc private func contentInset_clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        contentInset_clearButtonRect(forBounds: bounds)
            .inset(by: .init(top: 0, left: -contentInset.right, bottom: 0, right: contentInset.right))
            .inset(by: .init(top: contentInset.top, left: 0, bottom: -contentInset.top, right: 0))
            .inset(by: .init(top: -contentInset.bottom, left: 0, bottom: contentInset.bottom, right: 0))
    }

    private static var swizzleClearButtonRect: Void = {
        let aClass: AnyClass! = object_getClass(UITextField())
        let originalMethod = class_getInstanceMethod(aClass, #selector(clearButtonRect(forBounds:)))
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(contentInset_clearButtonRect(forBounds:)))
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        else {
            debugPrint("UITextField swizzleClearButtonRect failed")
        }
    }()
}
