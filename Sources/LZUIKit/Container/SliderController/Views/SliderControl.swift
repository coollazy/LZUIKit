import UIKit

open class SliderControl: UIControl {
    open var showedItemCount: CGFloat = 4.0
    public var textColor: UIColor?
    public var font: UIFont?
    public var selectedTextColor: UIColor? {
        didSet {
            selectedView.tintColor = selectedTextColor
        }
    }
    public var selectedFont: UIFont?
    public var items: [String]? {
        didSet {
            sendActions(for: .valueChanged)
        }
    }
    public var selectedIndex: Int {
        get {
            collectionView.indexPathsForSelectedItems?.first?.row ?? -1
        }
        set {
            guard newValue >= 0, newValue < (items?.count ?? 0)  else {
                return
            }
            let indexPath = IndexPath(row: newValue, section: 0)
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            updateSelectedViewBy(indexPath: indexPath)
        }
    }
    public lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    public lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SliderCell.self, forCellWithReuseIdentifier: SliderCell.reusedIdentifier)
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    public lazy var selectedView: UIView = {
        let sliderUnderlineView = SliderUnderlineView(frame: .zero)
        sliderUnderlineView.tintColor = selectedTextColor ?? .clear
        return sliderUnderlineView
    }()

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeSubViews()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubViews()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        let itemSize = CGSize(width: frame.width / showedItemCount, height: frame.height)
        collectionLayout.itemSize = itemSize
        selectedView.frame.size = itemSize
    }

    private func initializeSubViews() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        collectionView.addSubview(selectedView)
    }

    private func updateSelectedViewBy(indexPath: IndexPath) {
        if let cellRect = collectionView.layoutAttributesForItem(at: indexPath)?.frame {
            layoutIfNeeded()
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, animations: { [weak self] in
                self?.selectedView.frame.origin = .init(x: cellRect.minX, y: 0)
                self?.layoutIfNeeded()
            })
        }
    }
}

extension SliderControl: UICollectionViewDataSource {
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items?.count ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCell.reusedIdentifier, for: indexPath)
        if let cell = cell as? SliderCell, let item = items?[indexPath.row] {
            cell.textColor = textColor ?? .systemGray
            cell.font = font
            cell.selectedTextColor = selectedTextColor ?? .systemBlue
            cell.selectedFont = selectedFont
            cell.textLabel.text = item
        }
        return cell
    }
}

extension SliderControl: UICollectionViewDelegate {
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sendActions(for: .touchUpInside)
        updateSelectedViewBy(indexPath: indexPath)
    }
}
