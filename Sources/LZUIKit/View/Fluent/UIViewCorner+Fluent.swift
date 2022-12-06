import UIKit

extension UIView {
    @discardableResult
    public func setCornerType(_ type: CornerType) -> Self {
        cornerType(type)
        return self
    }
    
    @discardableResult
    public func setCornerLength(_ length: Float) -> Self {
        cornerLength(length)
        return self
    }
}
