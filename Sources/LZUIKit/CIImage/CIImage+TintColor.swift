import Foundation

public extension CIImage {
    func tinted(color: UIColor) -> CIImage? {
        guard let colorFilter = CIFilter(name: "CIFalseColor") else {
            return nil
        }
        
        colorFilter.setValue(self, forKey: kCIInputImageKey)
        colorFilter.setValue(CIColor(color: color), forKey: "inputColor0")
        colorFilter.setValue(CIColor(color: UIColor.white), forKey: "inputColor1")
        return colorFilter.outputImage
    }
}
