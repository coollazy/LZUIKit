import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    public var pushControllerItem: Binder<ControllerItem> {
        Binder(self.base) { controller, item in
            if let viewController = item.viewController {
                controller.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    public var presentControllerItem: Binder<ControllerItem> {
        Binder(self.base) { controller, item in
            if let viewController = item.viewController {
                controller.present(viewController, animated: true)
            }
        }
    }
}
