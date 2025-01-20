import UIKit

public extension UIImage {
    static func withColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        color.image(size)
    }
}
