import UIKit

open class SliderController: ScrollController {
    public lazy var control: SliderControl = {
        let sliderControl = SliderControl()
        sliderControl.translatesAutoresizingMaskIntoConstraints = false
        return sliderControl
    }()

    open override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(control)
        NSLayoutConstraint.activate([
            control.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            control.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            control.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            control.heightAnchor.constraint(equalToConstant: 42),
        ])
        
        let constraints = scrollView.superview?.constraints.filter({ constraint in
            constraint.firstItem is UIScrollView || constraint.secondItem is UIScrollView
        }) ?? []
        NSLayoutConstraint.deactivate(constraints)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 42),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        control.addTarget(self, action: #selector(controlDidSelectedIndex), for: .touchUpInside)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let selectedIndex = selectedIndex, selectedIndex != scrollView.currenttPageIndex {
            scrollView.currenttPageIndex = selectedIndex
        }
    }

    public override func setViewControllers(_ viewControllers: [UIViewController]) {
        control.items = viewControllers.map({ $0.title ?? "NoTitle" })

        super.setViewControllers(viewControllers)
    }

    open override func setSelected(viewController: UIViewController, shouldScroll: Bool = true) {
        super.setSelected(viewController: viewController, shouldScroll: shouldScroll)

        guard let currentIndex = viewControllers.firstIndex(of: viewController) else {
            print("[Error][SliderController] setSelected(viewController: \(viewController)), viewController is not exist")
            return
        }
        if control.selectedIndex != currentIndex {
            control.selectedIndex = currentIndex
        }
    }
    
    @objc private func controlDidSelectedIndex(_ sender: SliderControl) {
        selectedIndex = sender.selectedIndex
    }
}
