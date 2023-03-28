import Foundation

public protocol JSONData: Encodable {
    func jsonData() throws -> Data
}

extension JSONData {
    public func jsonData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
