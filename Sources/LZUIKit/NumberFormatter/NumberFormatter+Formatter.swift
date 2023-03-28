import Foundation

extension NumberFormatter {
    public class func formatter(from: NSNumber, prefix: String = "", suffix: String = "", numberOfDecimal: Int = 0, minimumFractionDigits: Int = 0) -> String? {
        let formatter = NumberFormatter()
        var format = prefix + "###,###"
        if numberOfDecimal > 0 {
            format += "."
            for _ in 0 ..< numberOfDecimal {
                format += "#"
            }
        }
        format += suffix
        formatter.positiveFormat = format
        formatter.minimumFractionDigits = minimumFractionDigits
        return formatter.string(from: from)
    }
}
