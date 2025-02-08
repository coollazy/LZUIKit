import UIKit

public protocol Loading: NSObject {
    /// Loading畫面。有預設樣式，可放客製化的View
    static var loadingView: UIView { get }
    /// Loading畫面。有預設樣式，可放客製化的View
    var loadingView: UIView { get set }
    
    func showLoadingView(duration: TimeInterval, curve: UIView.AnimationCurve)
    func showLoadingView(in view: UIView, duration: TimeInterval, curve: UIView.AnimationCurve)
    func hideLoadingView(duration: TimeInterval, curve: UIView.AnimationCurve)
}

public extension Loading {
    static var loadingView: UIView {
        LoadingView()
    }
    
    var loadingView: UIView {
        get {
            let key: StaticString = "Protocol LoadingView"
            guard let view = objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIView else {
                let view = Self.loadingView
                objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return view
            }
            return view
        }
        set {
            let key: StaticString = "Protocol LoadingView"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var transitionView: UIView {
        get {
            let key: StaticString = "Protocol TransitionView"
            guard let view = objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIView else {
                let view = TransitionView()
                objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return view
            }
            return view
        }
        set {
            let key: StaticString = "Protocol TransitionView"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showLoadingView(duration: TimeInterval = 0.3, curve: UIView.AnimationCurve = .linear) {
        // TODO: 支援 ios15 之後取得 window 的寫法
        guard let window = UIApplication.shared.windows.first else {
            print("[WARNING] Try to showLoadingView, but transitionView already has superview")
            return
        }
        
        showLoadingView(in: window, duration: duration, curve: curve)
    }
    
    func showLoadingView(in view: UIView, duration: TimeInterval = 0.3, curve: UIView.AnimationCurve = .linear) {
        guard transitionView.superview == nil else {
            print("[WARNING] Try to showLoadingView, but transitionView already has superview")
            return
        }
        guard loadingView.superview == nil else {
            print("[WARNING] Try to showLoadingView, but loadingView already has superview")
            return
        }
        
        transitionView.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: transitionView.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: transitionView.centerYAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: loadingView.frame.size.width),
            loadingView.heightAnchor.constraint(equalToConstant: loadingView.frame.size.height),
        ])
        
        transitionView.alpha = 0
        view.addSubview(transitionView)
        UIViewPropertyAnimator(duration: duration, curve: curve) { [weak self] in
            self?.transitionView.alpha = 1
        }
        .startAnimation()
    }
    
    func hideLoadingView(duration: TimeInterval = 0.3, curve: UIView.AnimationCurve = .linear) {
        guard transitionView.superview != nil else {
            return
        }
        
        transitionView.alpha = 1
        let animator = UIViewPropertyAnimator(duration: duration, curve: curve) { [weak self] in
            self?.transitionView.alpha = 0
        }
        animator.addCompletion({ [weak self] _ in
            self?.transitionView.removeFromSuperview()
            self?.loadingView.removeFromSuperview()
        })
        animator.startAnimation()
    }
}
