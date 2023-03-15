import Foundation
import UIKit

public class ControllerItem: Codable {
    public let controller: String
    public let nibName: String?
    
    public init() {
        self.controller = "UIViewController"
        self.nibName = nil
    }
    
    public init(controller: String, nibName: String? = nil) {
        self.controller = controller
        self.nibName = nibName
    }
    
    public var viewController: UIViewController? {
        guard let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String  else {
            return nil
        }
        guard let className = NSClassFromString("\(appName).\(controller)") as? UIViewController.Type else {
            return nil
        }
        if let nibName = nibName {
            return className.init(nibName: nibName, bundle: nil)
        }
        return className.init()
    }
}
