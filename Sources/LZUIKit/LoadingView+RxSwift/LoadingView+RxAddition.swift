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
    
    public func showLoadingView(in view: UIView, duration: TimeInterval = 0.3, curve: UIView.AnimationCurve = .linear) -> Binder<Bool> {
        Binder(self.base) { controller, show in
            if show {
                controller.showLoadingView(in: view, duration: duration, curve: curve)
            } else {
                controller.hideLoadingView()
            }
        }
    }
}
