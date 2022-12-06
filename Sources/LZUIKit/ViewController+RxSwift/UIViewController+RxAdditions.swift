import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    public var pushViewController: Binder<UIViewController> {
        Binder(self.base) { controller, viewController in
            controller.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    public var popViewController: Binder<Void> {
        Binder(self.base) { controller, _ in
            controller.navigationController?.popViewController(animated: true)
        }
    }
    
    public var presentController: Binder<UIViewController> {
        Binder(self.base) { controller, viewController in
            controller.present(viewController, animated: true)
        }
    }
    
    public var dismiss: Binder<Void> {
        Binder(self.base) { controller, _ in
            controller.dismiss(animated: true)
        }
    }
}
