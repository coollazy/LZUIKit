import Foundation

extension Array {
    // 切割 Arry
    public func slice(_ from: Int = 0, _ size: Int) -> [Element] {
        guard count != 0 else {
            return self
        }
        return stride(from: from, to: count, by: size)
            .map {
                Array(self[$0 ..< Swift.min($0 + size, count)])
            }
            .first!
    }
}
