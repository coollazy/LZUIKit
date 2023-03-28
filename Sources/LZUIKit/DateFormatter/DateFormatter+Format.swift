import Foundation

extension DateFormatter {
    public convenience init(format: String) {
        self.init()
        dateFormat = format
    }
}
