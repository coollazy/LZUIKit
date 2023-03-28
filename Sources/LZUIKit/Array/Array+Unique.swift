import Foundation

extension Array where Element: Hashable {
    // 過濾 Array 內重複的資料
    public func unique() -> [Element] {
        Array(Set(self))
    }
}
