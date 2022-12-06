import UIKit

extension UIViewController {
    fileprivate var loadingView: UIView {
        get {
            let key: StaticString = "UIViewController+loadingView"
            return objc_getAssociatedObject(self, UnsafeRawPointer(key.utf8Start)) as? UIView ?? createLoadingView()
        }
        set {
            let key: StaticString = "UIViewController+loadingView"
            objc_setAssociatedObject(self, UnsafeRawPointer(key.utf8Start), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate func createLoadingView() -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
        
        let backgroundViewSize = CGSize(width: 260, height: 60)
        let backgroundView = UIView(frame: CGRect(
            x: view.center.x - backgroundViewSize.width * 0.5,
            y: view.center.y - backgroundViewSize.height * 0.5 + 8,
            width: backgroundViewSize.width,
            height: backgroundViewSize.height))
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = backgroundViewSize.height * 0.25
        backgroundView.layer.masksToBounds = true
        view.addSubview(backgroundView)
        
        let label = UILabel()
        label.text = "Loading ..."
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.sizeToFit()
        label.center = CGPoint(x: backgroundViewSize.width * 0.5 - 20, y: backgroundViewSize.height * 0.5)
        label.backgroundColor = .clear
        backgroundView.addSubview(label)
        
        let indicatorViewSize = CGSize(width: 40, height: 40)
        let indicatorView = UIActivityIndicatorView(frame: CGRect(
            x: label.frame.maxX + 8,
            y: backgroundViewSize.height * 0.5 - indicatorViewSize.height * 0.5,
            width: indicatorViewSize.width,
            height: indicatorViewSize.height))
        indicatorView.hidesWhenStopped = true
        indicatorView.style = .gray
        indicatorView.startAnimating()
        backgroundView.addSubview(indicatorView)
        
        loadingView = view
        return view
    }
    
    public func showLoadingView() {
        guard loadingView.superview == nil else {
            return
        }
        loadingView.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(loadingView)
        UIViewPropertyAnimator(duration: 0.3, curve: .linear) { [weak self] in
            self?.loadingView.alpha = 1
        }
        .startAnimation()
    }
    
    public func hideLoadingView() {
        guard loadingView.superview != nil else {
            return
        }
        loadingView.alpha = 1
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) { [weak self] in
            self?.loadingView.alpha = 0
        }
        animator.addCompletion({ [weak self] _ in
            self?.loadingView.removeFromSuperview()
        })
        animator.startAnimation()
    }
}


