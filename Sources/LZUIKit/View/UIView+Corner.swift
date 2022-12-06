import UIKit

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
            return
        }
        layer.cornerRadius = min(frame.height, frame.width) / CGFloat(type.rawValue)
        layer.masksToBounds = true
    }
    
    public func cornerLength(_ length:Float) {
        layer.cornerRadius = CGFloat(length)
        layer.masksToBounds = true
    }
}
