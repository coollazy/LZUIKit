import UIKit

public extension UIImage {
    static func qrCode(from text: String, tintColor: UIColor = .black, transform: CGAffineTransform) -> UIImage? {
        guard let ciImage = CIImage.qrCode(from: text, tintColor: tintColor, transform: transform) else {
            return nil
        }
        
        return .init(ciImage: ciImage)
    }
}

public extension UIImage {
    func detectQRCode(options: [String : Any]? = nil) -> [String]? {
        ciImage?.detectQRCode(options: options)
    }
}
