import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    public var showLoadingView: Binder<Bool> {
        Binder(self.base) { controller, show in
            if show {
                controller.showLoadingView()
            } else {
                controller.hideLoadingView()
            }
        }
    }
}
