import UIKit

class LoadingView: UIView {
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Loading ..."
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.sizeToFit()
        label.backgroundColor = .clear
        return label
    }()
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.hidesWhenStopped = true
        view.style = .gray
        view.startAnimating()
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        frame = CGRect(x: 0, y: 0, width: 260, height: 60)
        backgroundColor = .white
        layer.cornerRadius = frame.height * 0.25
        layer.masksToBounds = true
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -20),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: 40),
            indicatorView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
