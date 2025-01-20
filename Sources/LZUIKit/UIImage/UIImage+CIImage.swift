import UIKit
import CoreImage

public extension UIImage {
    var ciImage: CIImage? {
        CIImage(image: self)
    }
}
