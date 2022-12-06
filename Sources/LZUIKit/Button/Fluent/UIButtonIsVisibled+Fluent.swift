import UIKit

extension UIButton {
    @discardableResult public func setVisibledBackgroundColor(_ color: UIColor) -> Self {
        visibledBackgroundColor = color
        return self
    }
    
    @discardableResult public func setDisabledBackgroundColor(_ color: UIColor) -> Self {
        disabledBackgroundColor = color
        return self
    }
    
    @discardableResult public func setIsVisibled(_ visibled: Bool) -> Self {
        isVisibled = visibled
        return self
    }
}
