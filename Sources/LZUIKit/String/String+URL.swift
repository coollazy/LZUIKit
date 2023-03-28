import Foundation

extension String {
    public var url: URL {
        URL(fileURLWithPath: self)
    }
    
    public var pathComponents: [String] {
        url.pathComponents
    }
    
    public var lastPathComponent: String {
        url.lastPathComponent
    }
    
    public var pathExtension: String {
        url.pathExtension
    }
}

extension String {
    public func appendingPathComponent(_ pathComponent: String) -> String {
        url.appendingPathComponent(pathComponent).path
    }
    
    public func deletingLastPathComponent() -> String {
        url.deletingLastPathComponent().path
    }
}

extension String {
    public func appendingPathExtension(_ pathExtension: String) -> String {
        url.appendingPathExtension(pathExtension).path
    }
    
    public func deletingPathExtension() -> String {
        url.deletingPathExtension().path
    }
}
