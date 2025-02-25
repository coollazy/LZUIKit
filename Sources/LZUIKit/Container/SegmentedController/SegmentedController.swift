import UIKit

open class SegmentedController: ScrollController {
    public lazy var segmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.addTarget(self, action: #selector(onSegmentedControlTapped), for: .valueChanged)
        return segmentedControl
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32),
        ])

        scrollView.removeConstraints(scrollView.constraints)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    public override func setViewControllers(_ viewControllers: [UIViewController]) {
        segmentedControl.removeAllSegments()
        viewControllers.enumerated().forEach({ index, controller in
            segmentedControl.insertSegment(withTitle: controller.title, at: index, animated: false)
        })

        super.setViewControllers(viewControllers)
    }

    open override func setSelected(viewController: UIViewController, shouldScroll: Bool = true) {
        super.setSelected(viewController: viewController, shouldScroll: shouldScroll)

        guard let currentIndex = viewControllers.firstIndex(of: viewController) else {
            print("[Error][SegmentedController] setSelected(viewController: \(viewController)), viewController is not exist")
            return
        }
        if segmentedControl.selectedSegmentIndex != currentIndex {
            segmentedControl.selectedSegmentIndex = currentIndex
        }
    }
    
    @objc
    private func onSegmentedControlTapped() {
        selectedIndex = segmentedControl.selectedSegmentIndex
    }
}
