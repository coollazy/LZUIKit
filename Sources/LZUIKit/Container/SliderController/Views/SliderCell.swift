import UIKit

open class SliderCell: UICollectionViewCell {
    static var reusedIdentifier = "SliderCell"

    public var textColor: UIColor = .systemGray {
        didSet {
            if isSelected == false {
                textLabel.textColor = textColor
            }
        }
    }
    public var font: UIFont? {
        didSet {
            if isSelected == false {
                textLabel.font = font
            }
        }
    }
    public var selectedTextColor: UIColor = .systemBlue {
        didSet {
            if isSelected == true {
                textLabel.textColor = selectedTextColor
            }
        }
    }
    public var selectedFont: UIFont? {
        didSet {
            if isSelected == true {
                textLabel.font = selectedFont
            }
        }
    }
    public lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeSubViews()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubViews()
    }

    private func initializeSubViews() {
        backgroundColor = .clear

        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        textLabel.text = nil
        isSelected = false
    }

    open override var isSelected: Bool {
        didSet {
            textLabel.textColor = isSelected ? selectedTextColor : textColor
            textLabel.font = isSelected ? selectedFont : font
        }
    }
}
