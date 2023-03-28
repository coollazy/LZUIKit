import Foundation

fileprivate let extensionFormatter = DateFormatter()

extension Date {
    // 用 string 初始化 Date, format 帶入日期的格式
    public init(string: String, format: String = "yyyy-MM-dd HH:mm:ss") {
        self.init(timeIntervalSince1970: Date.from(string: string, format: format)?.timeIntervalSince1970 ?? Date().timeIntervalSince1970)
    }
    
    public init(iso8601: String) {
        let formatter = DateFormatter(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        self = formatter.date(from: iso8601) ?? Date()
    }
    
    public static func from(string: String, format: String) -> Date? {
        extensionFormatter.locale = .current
        extensionFormatter.dateFormat = format
        return extensionFormatter.date(from: string)
    }
    
    public func formatter(format: String) -> String {
        extensionFormatter.dateFormat = format
        return extensionFormatter.string(from: self)
    }
}
    
extension Date {
    public var yaer: String {
        extensionFormatter.dateFormat = "yyyy"
        return extensionFormatter.string(from: self)
    }
    
    public var month: String {
        extensionFormatter.dateFormat = "MM"
        return extensionFormatter.string(from: self)
    }
    
    public var day: String {
        extensionFormatter.dateFormat = "dd"
        return extensionFormatter.string(from: self)
    }
    
    public var hour: String {
        extensionFormatter.dateFormat = "HH"
        return extensionFormatter.string(from: self)
    }
    
    public var minute: String {
        extensionFormatter.dateFormat = "mm"
        return extensionFormatter.string(from: self)
    }
    
    public var second: String {
        extensionFormatter.dateFormat = "ss"
        return extensionFormatter.string(from: self)
    }
}
