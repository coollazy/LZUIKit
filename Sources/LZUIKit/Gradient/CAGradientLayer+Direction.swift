import UIKit

public extension CAGradientLayer {
    enum Direction {
        case leftToRight
        case rightToLeft
        case topToBottom
        case bottomToTop
        case leftTopToRightBottom
        case rightBottomToLeftTop
        case leftBottomToRightTop
        case rightTopToLeftBottom
    }

    @discardableResult
    func setDirection(_ direction: Direction) -> Self {
        switch direction {
        case .leftToRight:
            startPoint = CGPoint(x: 0.0, y: 0.5)
            endPoint = CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft:
            startPoint = CGPoint(x: 1.0, y: 0.5)
            endPoint = CGPoint(x: 0.0, y: 0.5)
        case .bottomToTop:
            startPoint = CGPoint(x: 0.5, y: 1.0)
            endPoint = CGPoint(x: 0.5, y: 0.0)
        case .topToBottom:
            startPoint = CGPoint(x: 0.5, y: 0.0)
            endPoint = CGPoint(x: 0.5, y: 1.0)
        case .leftTopToRightBottom:
            startPoint = CGPoint(x: 0.0, y: 0.0)
            endPoint = CGPoint(x: 1.0, y: 1.0)
        case .rightBottomToLeftTop:
            startPoint = CGPoint(x: 1.0, y: 1.0)
            endPoint = CGPoint(x: 0.0, y: 0.0)
        case .leftBottomToRightTop:
            startPoint = CGPoint(x: 0.0, y: 1.0)
            endPoint = CGPoint(x: 1.0, y: 0.0)
        case .rightTopToLeftBottom:
            startPoint = CGPoint(x: 1.0, y: 0.0)
            endPoint = CGPoint(x: 0.0, y: 1.0)
        }
        return self
    }
}
