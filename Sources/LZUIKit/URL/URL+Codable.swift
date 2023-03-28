import Foundation

extension URL {
    public func data() throws -> Data {
        try Data(contentsOf: self)
    }
}
