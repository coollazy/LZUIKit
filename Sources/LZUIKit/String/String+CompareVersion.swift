import Foundation

extension String {
    // 判斷版本號是否大於(必須為相同格式版本號, 數字與.的組合)
    public func isGreaterThan(version: String) -> Bool {
        guard isSameVersionType(version: version) else {
            return false
        }
        let currentVersions = split(separator: ".").map({ String($0) })
        let versions = version.split(separator: ".").map({ String($0) })
        return currentVersions.isGreaterThan(versions: versions)
    }
    
    // 判斷版本號是否小於(必須為相同格式版本號, 數字與.的組合)
    public func isLessThen(version: String) -> Bool {
        guard isSameVersionType(version: version) else {
            return false
        }
        let currentVersions = split(separator: ".").map({ String($0) })
        let versions = version.split(separator: ".").map({ String($0) })
        return currentVersions.isLessThen(versions: versions)
    }
    
    // 判斷版本號是否相等(必須為相同格式版本號, 數字與.的組合)
    public func isEqualTo(version: String) -> Bool {
        guard isSameVersionType(version: version) else {
            return false
        }
        let currentVersions = split(separator: ".").map({ String($0) })
        let versions = version.split(separator: ".").map({ String($0) })
        return currentVersions.isEqualTo(versions: versions)
    }
    
    // 判斷是否為相同格式的版本號
    public func isSameVersionType(version: String) -> Bool {
        split(separator: ".").count == version.split(separator: ".").count
    }
}

extension Array where Element == String {
    fileprivate func isGreaterThan(versions: [String]) -> Bool {
        guard count == versions.count else {
            return false
        }
        
        for (key, value) in enumerated() {
            if value.integerValue > versions[key].integerValue {
                return true
            } else if  value.integerValue < versions[key].integerValue {
                return false
            }
        }
        return false
    }
    
    fileprivate func isLessThen(versions: [String]) -> Bool {
        guard count == versions.count else {
            return false
        }
        guard isEqualTo(versions: versions) == false else {
            return false
        }
        
        return isGreaterThan(versions: versions) == false
    }
    
    fileprivate func isEqualTo(versions: [String]) -> Bool {
        guard count == versions.count else {
            return false
        }
        
        for (key, value) in enumerated() {
            if value.integerValue != versions[key].integerValue {
                return false
            }
        }
        return true
    }
}
