import Foundation

extension String {
    public var integerValue: Int {
        (self as NSString).integerValue
    }
    
    public var floatValue: Float {
        (self as NSString).floatValue
    }
    
    public var doubleValue: Double {
        (self as NSString).doubleValue
    }
}
