import Foundation

public extension CIImage {
    static func qrCode(from text: String, tintColor: UIColor = .black, transform: CGAffineTransform) -> CIImage? {
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        filter?.setValue(text.data(using: .utf8), forKeyPath: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        guard let cgImage = filter?.outputImage?.cgImage else {
            return nil
        }
        
        return .init(cgImage: cgImage)
            .tinted(color: tintColor)?
            .transformed(by: transform)
    }
}

public extension CIImage {
    func detectQRCode(options: [String : Any]? = nil) -> [String]? {
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: options)
        return detector?.features(in: self)
            .map { $0 as? CIQRCodeFeature }
            .compactMap { $0?.messageString }
    }
}
