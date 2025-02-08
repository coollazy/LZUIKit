import UIKit

class TransitionView: UIView {
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        frame = UIScreen.main.bounds
        backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
    }
}
