import UIKit
import CoreImage

public extension CIImage {
    var uiImage: UIImage {
        UIImage(ciImage: self)
    }
}
