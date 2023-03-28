import Foundation

extension Date {
    // 從 fromDate 到目前 Date 的間隔天數
    public func intervalDays(fromDate: Date) -> Int {
        let dateComponents = Calendar.current.dateComponents([.day], from: fromDate, to: self)
        return dateComponents.day ?? 0
    }
    
    // 從 Date 到目前 toDate 的間隔天數
    public func intervalDays(toDate: Date) -> Int {
        let dateComponents = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return dateComponents.day ?? 0
    }
}

extension Date {
    // 判斷 Date 是否相等，format 可設定判斷的日期格式
    public func isEqualTo(date: Date, format: String = "yyyy-MM-dd HH:mm:ss") -> Bool {
        return formatter(format: format) == date.formatter(format: format)
    }
    
    // 判斷是否大於 Date ，format 可設定判斷的日期格式
    public func isGreaterThan(date: Date, format: String = "yyyy-MM-dd HH:mm:ss") -> Bool {
        return formatter(format: format) > date.formatter(format: format)
    }
    
    // 判斷是否小於 Date，format 可設定判斷的日期格式
    public func isLessThan(date: Date, format: String = "yyyy-MM-dd HH:mm:ss") -> Bool {
        return formatter(format: format) < date.formatter(format: format)
    }
}
