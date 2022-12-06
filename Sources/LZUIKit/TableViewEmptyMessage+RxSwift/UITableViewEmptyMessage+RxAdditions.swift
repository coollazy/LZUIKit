import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    public var emptyMessage: Binder<String> {
        Binder(self.base) { view, value in
            view.emptyMessage = value
        }
    }
    
    public var isHiddenEmptyMessage: Binder<Bool> {
        Binder(self.base) { view, value in
            view.isHiddenEmptyMessage = value
        }
    }
}
