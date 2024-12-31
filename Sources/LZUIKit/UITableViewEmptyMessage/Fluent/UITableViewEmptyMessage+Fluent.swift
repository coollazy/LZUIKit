import UIKit

extension UITableView {
    @discardableResult
    public func setEmptyMessageFontSize(_ size: CGFloat) -> Self {
        emptyMessageFontSize = size
        return self
    }
    
    @discardableResult
    public func setEmptyMessageFontWeight(_ weight: UIFont.Weight) -> Self {
        emptyMessageFontWeight = weight
        return self
    }
    
    @discardableResult
    public func setEmptyMessageColor(_ color: UIColor) -> Self {
        emptyMessageColor = color
        return self
    }
    
    @discardableResult
    public func setEmptyMessage(_ message: String) -> Self {
        emptyMessage = message
        return self
    }
    
    @discardableResult
    public func setIsHiddenEmptyMessage(_ hidden: Bool) -> Self {
        isHiddenEmptyMessage = hidden
        return self
    }
}
