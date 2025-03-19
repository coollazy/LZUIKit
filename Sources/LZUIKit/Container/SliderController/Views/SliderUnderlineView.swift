import UIKit

class SliderUnderlineView: UIView {
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = tintColor
        view.layer.cornerRadius = CGFloat(2)
        view.layer.masksToBounds = true
        return view
    }()

    override var tintColor: UIColor! {
        didSet {
            underlineView.backgroundColor = tintColor
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    private func initialize() {
        isUserInteractionEnabled = false
        backgroundColor = .clear
        
        addSubview(underlineView)
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underlineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            underlineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            underlineView.widthAnchor.constraint(equalToConstant: 24),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
        ])
    }
}
