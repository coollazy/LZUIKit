import UIKit

extension UITableView {
    public static func enableEmptyContentView() {
        _ = self.swizzleImplementation
    }
}

extension UITableView {
    private static var swizzleImplementation: Void = {
        let originalMethod = class_getInstanceMethod(UITableView.self, #selector(layoutSubviews))
        let swizzledMethod = class_getInstanceMethod(UITableView.self, #selector(tableview_empty_content_view_layoutSubviews))
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        else {
            print("UITableView enableEmptyContentView => Failed")
        }
    }()

    @objc func tableview_empty_content_view_layoutSubviews() {
        tableview_empty_content_view_layoutSubviews()

        // 預設會自動將 emptyContentView 的大小設定跟 TableView 一樣
        emptyContentView?.frame = .init(x: 0, y: 0, width: frame.width, height: frame.height)

        if isItemsCountEqualToZero() {
            // 當資料筆數為0
            if let emptyContentView = emptyContentView {
                if emptyContentView.superview == nil {
                    addSubview(emptyContentView)
                }
                emptyContentView.isHidden = false
            }
        }
        else if emptyContentView?.isHidden == false {
            emptyContentView?.isHidden = true
        }
    }
}

extension UITableView {
    // 當資料為空時，會顯示在TableView上的自定義畫面
    public var emptyContentView: UIView? {
        get {
            let key: StaticString = "UITableView+EmptyContentView_emptyContentView"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIView
        }
        set {
            let key: StaticString = "UITableView+EmptyContentView_emptyContentView"
            // 當設定為nil時，表示要移除目前的 emptyContentView
            if newValue == nil {
                let oldView = objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIView
                oldView?.removeFromSuperview()
            }
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private func isItemsCountEqualToZero() -> Bool {
        for section in 0 ..< numberOfSections {
            guard numberOfRows(inSection: section) == 0 else {
                return false
            }
        }
        return true
    }
}

// Fluent interface
extension UITableView {
    @discardableResult
    public func setEmptyContentView(_ view: UIView?) -> Self {
        emptyContentView = view
        return self
    }
}
