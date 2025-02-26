import UIKit
import Combine

open class ScrollController: ContainerController {
    private var cancellables = Set<AnyCancellable>()
    private var viewWillAppearOnce = false
    private var viewDidAppearOnce = false
    private var _selectedViewController: UIViewController?

    public private(set) var viewControllers = [UIViewController]()
    public lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    public var selectedIndex: Int? {
        get {
            guard let selectedViewController = selectedViewController else {
                return nil
            }
            return viewControllers.firstIndex(where: { $0 == selectedViewController })
        }
        set {
            guard let index = newValue else {
                return
            }
            setSelected(index: index)
        }
    }

    public var selectedViewController: UIViewController? {
        get {
            _selectedViewController
        }
        set {
            if let newViewController = newValue {
                setSelected(viewController: newViewController)
            }
        }
    }

    public override var visibledControllers: [UIViewController] {
        guard let selectedViewController = selectedViewController else {
            return []
        }
        return [selectedViewController]
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        
        scrollView.publisher(for: \.contentOffset)
            .map { [weak self] point -> Int in
                if point.x == 0 {
                    return 0
                }
                if let width = self?.scrollView.frame.width {
                    return Int(round(point.x / width))
                }
                return 0
            }
            .removeDuplicates()
            .sink { [weak self] index in
                let count = self?.viewControllers.count ?? 0
                let selectedIndex = self?.selectedIndex ?? 0
                if index < count, index != selectedIndex, let viewController = self?.viewControllers[index] {
                    self?.setSelected(viewController: viewController, shouldScroll: false)
                }
            }
            .store(in: &cancellables)
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearOnce = true
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearOnce = true
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewControllers.enumerated().forEach({ index, controller in
            controller.view.frame = CGRect(
                x: CGFloat(index) * scrollView.frame.width,
                y: 0.0,
                width: scrollView.frame.width,
                height: scrollView.frame.height
            )
        })
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(viewControllers.count), height: scrollView.frame.height)
    }

    public func setViewControllers(_ viewControllers: [UIViewController]) {
        removeAllControllers()
        self.viewControllers = viewControllers
            .map({ viewController in
                if viewController.parent != nil {
                    viewController.removeFromParent()
                }
                addChild(viewController)
                if viewController.view.superview != nil {
                    viewController.view.removeFromSuperview()
                }
                return viewController
            })

        viewControllers.enumerated().forEach({ index, controller in
            controller.view.frame = CGRect(
                x: CGFloat(index) * scrollView.frame.width,
                y: 0.0,
                width: scrollView.frame.width,
                height: scrollView.frame.height
            )
            scrollView.addSubview(controller.view)
        })
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(viewControllers.count), height: scrollView.frame.height)

        setSelected(index: selectedIndex ?? 0)
    }

    public func removeAllControllers() {
        viewControllers
            .forEach({ viewController in
                viewController.removeFromParent()
                viewController.view.removeFromSuperview()
            })
        viewControllers = []
        _selectedViewController = nil
    }

    private func setSelected(index: Int) {
        guard index >= 0 else {
            return
        }
        guard index < viewControllers.count else {
            print("[Error][ScrollController] setSelected(index: \(index)), index \(index) is out of range \(viewControllers.count)")
            return
        }
        guard index != selectedIndex else {
            return
        }
        setSelected(viewController: viewControllers[index])
    }

    open func setSelected(viewController: UIViewController, shouldScroll: Bool = true) {
        guard let currentIndex = viewControllers.firstIndex(of: viewController) else {
            print("[Error][ScrollController] setSelected(viewController: \(viewController)), viewController is not exist")
            return
        }
        deselectViewController(_selectedViewController)
        selectViewController(viewController)
        if shouldScroll {
            scrollView.currenttPageIndex = currentIndex
        }
    }
}

extension ScrollController {
    fileprivate func selectViewController(_ viewController: UIViewController?) {
        guard let viewController = viewController else {
            return
        }
        if viewWillAppearOnce {
            viewController.beginAppearanceTransition(true, animated: false)
        }
        addChild(viewController)
        if viewDidAppearOnce {
            viewController.endAppearanceTransition()
        }
        viewController.didMove(toParent: self)
        _selectedViewController = viewController
    }

    fileprivate func deselectViewController(_ viewController: UIViewController?) {
        guard let viewController = viewController else {
            return
        }
        viewController.willMove(toParent: nil)
        viewController.beginAppearanceTransition(false, animated: false)
        viewController.endAppearanceTransition()
        viewController.removeFromParent()
        _selectedViewController = nil
    }
}
