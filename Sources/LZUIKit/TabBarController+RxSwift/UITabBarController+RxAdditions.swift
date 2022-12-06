import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITabBarController {
    public var viewControllers: Binder<[UIViewController]> {
        Binder(self.base) { controller, viewControllers in
            controller.setViewControllers(viewControllers, animated: true)
        }
    }
}
