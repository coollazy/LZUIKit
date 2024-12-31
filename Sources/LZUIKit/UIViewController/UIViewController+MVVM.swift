import UIKit

/**
 自定義 UIViewController life cycle

 需要在 AppDelegate 呼叫 UIViewController.enableMVVMLifeCycle()
 
 順序如下
 1. viewDidLoad (原生的)
 2. setupUI
 3. bindViews
 4. bindViewModel
 5. emitEvents
 */
extension UIViewController {
    /**
     初始化 view 或是 subViews，或是將 subView 加到 view 上
     */
    @objc open func setupUI() {}

    /**
     View 與 View, View 與 ViewController 相關的 binding
     */
    @objc open func bindViews() {}

    /**
     與 ViewModel 相關的 binding
     **/
    @objc open func bindViewModel() {}

    /**
     View 與 ViewModel binding 結束
     */
    @objc open func emitEvents() {}
}

/**
 用 swizzle hook UIViewController 原本的 viewDidLoad
 增加 setupUI, bindViews, bindViewModel, emitEvents
 */
extension UIViewController {
    public static func enableMVVMLifeCycle() {
        _ = self.swizzleImplementation
    }

    @objc private func mvvm_viewDidLoad() {
        mvvm_viewDidLoad()

        setupUI()
        bindViews()
        bindViewModel()
        emitEvents()
    }

    private static var swizzleImplementation: Void = {
        let originalMethod = class_getInstanceMethod(UIViewController.self, #selector(viewDidLoad))
        let swizzledMethod = class_getInstanceMethod(UIViewController.self, #selector(mvvm_viewDidLoad))
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        else {
            debugPrint("SwizzleImplementation failed")
        }
    }()
}
