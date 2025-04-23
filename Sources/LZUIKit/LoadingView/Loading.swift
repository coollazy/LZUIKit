import UIKit

public protocol Loading: NSObject {
    /// Loading畫面的 UIWindow。有預設，可自行指定要使用的 UIWindow
    static var loadingWindow: UIWindow { get }
    /// Transition畫面。有預設樣式，可放客製化的View
    static var transitionView: UIView { get }
    /// Loading畫面。有預設樣式，可放客製化的View
    static var loadingView: UIView { get }
    
    /// Loading畫面的 UIWindow。有預設，可自行指定要使用的 UIWindow
    var loadingWindow: UIWindow { get }
    /// Transition畫面。有預設樣式，可放客製化的View
    var transitionView: UIView { get }
    /// Loading畫面。有預設樣式，可放客製化的View
    var loadingView: UIView { get set }
    
    /// 全畫面顯示 LoadingView，預設顯示在 windowLevel = alert -2
    func showLoadingView(duration: TimeInterval, curve: UIView.AnimationCurve)
    /// 置中顯示 LoadingView 在指定的 view 上面
    func showLoadingView(in view: UIView, duration: TimeInterval, curve: UIView.AnimationCurve)
    
    func hideLoadingView(duration: TimeInterval, curve: UIView.AnimationCurve)
}

public extension Loading {
    static var loadingWindow: UIWindow {
        UIWindow.loadingLevelWindow
    }
    
    static var transitionView: UIView {
        TransitionView()
    }
    
    static var loadingView: UIView {
        LoadingView()
    }
}

public extension Loading {
    var loadingWindow: UIWindow {
        get {
            let key: StaticString = "Protocol Loading LoadingWindow"
            guard let view = objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIWindow else {
                let view = Self.loadingWindow
                objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return view
            }
            return view
        }
        set {
            let key: StaticString = "Protocol Loading LoadingWindow"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var transitionView: UIView {
        get {
            let key: StaticString = "Protocol Loading TransitionView"
            guard let view = objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIView else {
                let view = Self.transitionView
                objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return view
            }
            return view
        }
        set {
            let key: StaticString = "Protocol Loading TransitionView"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var loadingView: UIView {
        get {
            let key: StaticString = "Protocol Loading LoadingView"
            guard let view = objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIView else {
                let view = Self.loadingView
                objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return view
            }
            return view
        }
        set {
            let key: StaticString = "Protocol Loading LoadingView"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public extension Loading {
    func showLoadingView(duration: TimeInterval = 0.3, curve: UIView.AnimationCurve = .linear) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear
        let window = loadingWindow
        window.rootViewController = viewController
        window.show()
        
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
            self?.loadingWindow.hide()
        })
        animator.startAnimation()
    }
}
