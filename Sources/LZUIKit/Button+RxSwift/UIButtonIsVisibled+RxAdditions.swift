import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIButton {
    public var isVisibled: Binder<Bool> {
        Binder(self.base) { view, value in
            view.isVisibled = value
        }
    }
}
