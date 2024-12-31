import UIKit

open class ContainerController: UIViewController {
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        visibledControllers.forEach({ $0.beginAppearanceTransition(true, animated: animated) })
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        visibledControllers.forEach({ $0.endAppearanceTransition() })
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        visibledControllers.forEach({ $0.beginAppearanceTransition(false, animated: animated) })
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        visibledControllers.forEach({ $0.endAppearanceTransition() })
    }

    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        visibledControllers.forEach({ $0.viewWillTransition(to: size, with: coordinator) })
    }

    open override var shouldAutorotate: Bool {
        visibledControllers.reduce(false, { $0 && $1.shouldAutorotate })
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .init(rawValue: visibledControllers.reduce(UIInterfaceOrientationMask.all.rawValue, { $0 & $1.supportedInterfaceOrientations.rawValue }))
    }

    open override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        false
    }

    open override func shouldAutomaticallyForwardRotationMethods() -> Bool {
        false
    }

    open var visibledControllers: [UIViewController] {
        children
    }
}
