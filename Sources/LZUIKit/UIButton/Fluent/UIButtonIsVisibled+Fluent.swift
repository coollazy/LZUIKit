import UIKit

extension UIButton {
    @discardableResult
    public func setIsVisibled(_ visibled: Bool) -> Self {
        isVisibled = visibled
        return self
    }
}

extension UIButton {
    @discardableResult
    public func setOnVisibled(_ onVisibled: @escaping ((UIButton) -> Void)) -> Self {
        self.onVisibled = onVisibled
        return self
    }
    
    @discardableResult
    public func setOnDisabled(_ onDisabled: @escaping ((UIButton) -> Void)) -> Self {
        self.onDisabled = onDisabled
        return self
    }
}

extension UIButton {
    @discardableResult
    public func setVisibledTitleColor(_ color: UIColor) -> Self {
        visibledTitleColor = color
        return self
    }
    
    @discardableResult
    public func setDisabledTitleColor(_ color: UIColor) -> Self {
        disabledTitleColor = color
        return self
    }
    
    @discardableResult
    public func setVisibledBackgroundColor(_ color: UIColor) -> Self {
        visibledBackgroundColor = color
        return self
    }
    
    @discardableResult
    public func setDisabledBackgroundColor(_ color: UIColor) -> Self {
        disabledBackgroundColor = color
        return self
    }
}
