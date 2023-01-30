import UIKit

extension UITableView {
    fileprivate var currentSeparatorStyle: UITableViewCell.SeparatorStyle? {
        get {
            let key: StaticString = "currentSeparatorStyle"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UITableViewCell.SeparatorStyle
        }
        set {
            let key: StaticString = "currentSeparatorStyle"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public var emptyMessage: String? {
        get {
            let key: StaticString = "emptyMessage"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? String
        }
        set {
            let key: StaticString = "emptyMessage"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var emptyMessageFontSize: CGFloat {
        get {
            let key: StaticString = "emptyMessageFontSize"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? CGFloat ?? 14.0
        }
        set {
            let key: StaticString = "emptyMessageFontSize"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var emptyMessageFontWeight: UIFont.Weight {
        get {
            let key: StaticString = "emptyMessageFontWeight"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIFont.Weight ?? .regular
        }
        set {
            let key: StaticString = "emptyMessageFontWeight"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var emptyMessageColor: UIColor {
        get {
            let key: StaticString = "emptyMessageColor"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIColor ?? .darkGray
        }
        set {
            let key: StaticString = "emptyMessageColor"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var isHiddenEmptyMessage: Bool {
        get {
            let key: StaticString = "isHiddenEmptyMessage"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? Bool ?? false
        }
        set {
            let key: StaticString = "isHiddenEmptyMessage"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setNeedsLayout()
        }
    }

    func layoutEmptyView() {
        if currentSeparatorStyle == nil {
            currentSeparatorStyle = separatorStyle
        }
        
        for section in 0 ..< numberOfSections {
            if numberOfRows(inSection: section) != 0 {
                separatorStyle = currentSeparatorStyle ?? .none
                backgroundView = nil
                return
            }
        }

        // Set empty message
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: bounds.width, height: bounds.height))
        let messageView = UIView(frame: rect)
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 70, width: bounds.width, height: 20))
        messageLabel.text = emptyMessage ?? ""
        messageLabel.textColor = emptyMessageColor
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: emptyMessageFontSize, weight: emptyMessageFontWeight)
        messageLabel.isHidden = isHiddenEmptyMessage
        messageView.addSubview(messageLabel)

        backgroundView = messageView
        separatorStyle = .none
    }

    @objc func emptyAddition_layoutSubviews() {
        emptyAddition_layoutSubviews()
        layoutEmptyView()
    }

    private static var swizzleImplementation: Void = {
        let aClass: AnyClass! = object_getClass(UITableView())
        let originalMethod = class_getInstanceMethod(aClass, #selector(layoutSubviews))
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(emptyAddition_layoutSubviews))
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()

    public static func enableEmptyMessage() {
        _ = self.swizzleImplementation
    }
}

