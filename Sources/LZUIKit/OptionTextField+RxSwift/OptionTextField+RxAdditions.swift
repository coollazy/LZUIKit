import RxSwift
import RxCocoa

extension Reactive where Base: OptionTextField {
    public var options: Binder<[String]> {
        Binder(self.base) { view, value in
            view.options = value
        }
    }
}
