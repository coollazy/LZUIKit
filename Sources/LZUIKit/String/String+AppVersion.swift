import Foundation

extension String {
    public static var appVersion: String {
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""
        let build = Bundle.main.infoDictionary!["CFBundleVersion"] as? String ?? ""
    #if DEBUG
        return "\(version).\(build).debug"
    #else
        return "\(version).\(build)"
    #endif
    }
}
