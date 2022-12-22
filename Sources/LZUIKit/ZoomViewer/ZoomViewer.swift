import UIKit

public class ZoomViewer: UIView {
    private let scrollView: UIScrollView = UIScrollView()
    private let containerCapacity: Int = 3
    private var containers: [UIView] = [UIView]()
    private let contentView: UIView = UIView()
    private var scaleFactor: CGFloat = 1.0
    private var numberOfViews: Int = 0
    private var selectedIndex: Int?
    private let topLoadingView = UIActivityIndicatorView()
    private let bottomLoadingView = UIActivityIndicatorView()
    private let leftLoadingView = UIActivityIndicatorView()
    private let rightLoadingView = UIActivityIndicatorView()
    
    public weak var dataSource: ZoomViewerDataSource?
    public weak var delegate: ZoomViewerDelegate?
    
    public var currentIndex: Int {
        if direction == .horizontal {
            guard scrollView.contentOffset.x >= 0 else {
                return 0
            }
            return Int(round(scrollView.contentOffset.x / (scrollView.frame.width * scaleFactor)))
        }
        else {
            guard scrollView.contentOffset.y >= 0 else {
                return 0
            }
            return Int(round(scrollView.contentOffset.y / (scrollView.frame.height * scaleFactor)))
        }
    }
    
    public enum Direction {
        case horizontal
        case vertical
    }
    public var direction: Direction = .horizontal
    
    public var minimumZoomScale: CGFloat {
        set {
            scrollView.minimumZoomScale = newValue
        }
        get {
            scrollView.minimumZoomScale
        }
    }
    public var maximumZoomScale: CGFloat {
        set {
            scrollView.maximumZoomScale = newValue
        }
        get {
            scrollView.maximumZoomScale
        }
    }
    public var showsHorizontalScrollIndicator: Bool {
        set {
            scrollView.showsHorizontalScrollIndicator = newValue
        }
        get {
            scrollView.showsHorizontalScrollIndicator
        }
    }
    public var showsVerticalScrollIndicator: Bool {
        set {
            scrollView.showsVerticalScrollIndicator = newValue
        }
        get {
            scrollView.showsVerticalScrollIndicator
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = .init(x: 0, y: 0, width: frame.width, height: frame.height)
        contentView.frame = .init(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
        
        topLoadingView.frame = .init(x: 0, y: -50, width: scrollView.frame.width, height: 50)
        bottomLoadingView.frame = .init(x: 0, y: scrollView.frame.height + 50, width: scrollView.frame.width, height: 50)
        leftLoadingView.frame = .init(x: -50, y: 0, width: 50, height: scrollView.frame.height)
        rightLoadingView.frame = .init(x: scrollView.frame.width + 50, y: 0, width: 50, height: scrollView.frame.height)
        
        reloadData()
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        initializeView()
    }
    
    private func initializeView() {
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        for _ in 0 ..< containerCapacity {
            let container = dataSource?.zoomViewerCreateView() ?? UIView()
            container.frame = .zero
            containers.append(container)
            contentView.addSubview(container)
        }
        
        topLoadingView.frame = .init(x: 0, y: -50, width: scrollView.frame.width, height: 50)
        topLoadingView.hidesWhenStopped = true
        
        bottomLoadingView.frame = .init(x: 0, y: scrollView.frame.height + 50, width: scrollView.frame.width, height: 50)
        bottomLoadingView.hidesWhenStopped = true
        
        leftLoadingView.frame = .init(x: -50, y: 0, width: 50, height: scrollView.frame.height)
        leftLoadingView.hidesWhenStopped = true
        
        rightLoadingView.frame = .init(x: scrollView.frame.width + 50, y: 0, width: 50, height: scrollView.frame.height)
        rightLoadingView.hidesWhenStopped = true
        
        scrollView.addSubview(topLoadingView)
        scrollView.addSubview(bottomLoadingView)
        scrollView.addSubview(leftLoadingView)
        scrollView.addSubview(rightLoadingView)
        
    }
    
    // 預載畫面(預載上一頁及下一頁)
    fileprivate func preloadContentViewAt(index: Int) {
        // 加載上一頁
        if index > 0 {
            showContentAt(index: index - 1)
        }
        
        // 加載當前頁面
        showContentAt(index: index)
        
        // 加載下一頁
        if index + 1 < numberOfViews {
            showContentAt(index: index + 1)
        }
    }
    
    // 載入指定的頁面
    private func showContentAt(index: Int) {
        if index < numberOfViews, let dataSource = dataSource {
            // 計算 container index 應該用多少
            let containerIndex = index % containers.count
            
            // 移動 container 到正確位置
            let container = containers[containerIndex]
            let view = dataSource.zoomViewer(self, view: container, atIndex: index)
            if direction == .horizontal {
                container.frame = .init(
                    x: scrollView.frame.width * CGFloat(index),
                    y: 0,
                    width: scrollView.frame.width,
                    height: scrollView.frame.height
                )
            }
            else {
                container.frame = .init(
                    x: 0,
                    y: scrollView.frame.height * CGFloat(index),
                    width: scrollView.frame.width,
                    height: scrollView.frame.height
                )
            }
            
            if view.superview != contentView {
                view.removeFromSuperview()
                contentView.addSubview(view)
            }
        }
    }
}

extension ZoomViewer {
    public func reloadData() {
        guard let dataSource = dataSource else {
            print("[ERROR][ZoomViewer] Please set data source")
            return
        }
        
        numberOfViews = dataSource.zoomViewerNumberOfViews(self)
        if direction == .horizontal {
            scrollView.contentSize = .init(
                width: frame.width * scaleFactor * CGFloat(numberOfViews),
                height: frame.height * scaleFactor
            )
        }
        else {
            scrollView.contentSize = .init(
                width: frame.width * scaleFactor,
                height: frame.height * scaleFactor * CGFloat(numberOfViews)
            )
        }
        contentView.frame = CGRect(
            x: 0,
            y: 0,
            width: scrollView.contentSize.width,
            height: scrollView.contentSize.height
        )
        
        if numberOfViews > 0 {
            preloadContentViewAt(index: currentIndex)
        }
        
        if let selectedIndex = selectedIndex {
            setCurrentIndex(selectedIndex, animated: false)
            self.selectedIndex = nil
        }
    }
    
    @discardableResult
    public func setCurrentIndex(_ index: Int, animated: Bool = true) -> Self {
        selectedIndex = index
        if index >= 0, index < numberOfViews {
            if direction == .horizontal {
                let x = CGFloat(index) * scaleFactor * scrollView.frame.width
                scrollView.setContentOffset(.init(x: x, y: 0), animated: animated)
            }
            else {
                let y = CGFloat(index) * scaleFactor * scrollView.frame.height
                scrollView.setContentOffset(.init(x: 0, y: y), animated: animated)
            }
        }
        return self
    }
}

// Refreshing
extension ZoomViewer {
    public func endRefreshing() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            if self?.topLoadingView.isAnimating == true {
                self?.topLoadingView.stopAnimating()
            }
            else if self?.bottomLoadingView.isAnimating == true {
                self?.bottomLoadingView.stopAnimating()
            }
            else if self?.leftLoadingView.isAnimating == true {
                self?.leftLoadingView.stopAnimating()
            }
            else if self?.rightLoadingView.isAnimating == true {
                self?.rightLoadingView.stopAnimating()
            }
            self?.scrollView.contentInset = .zero
        }
    }
    
    fileprivate func handleScrollViewDidScroll() {
        if direction == .horizontal {
            if delegate?.zoomViewerWillRefreshLeft(self) == true, scrollView.contentOffset.x <= -50 {
                leftLoadingView.frame = .init(
                    x: -50,
                    y: 0,
                    width: 50,
                    height: scrollView.frame.height
                )
                leftLoadingView.startAnimating()
            }
            else if delegate?.zoomViewerWillRefreshRight(self) == true, scrollView.contentOffset.x >= contentView.frame.width - scrollView.frame.width + 50 {
                rightLoadingView.frame = .init(
                    x: contentView.frame.width,
                    y: 0,
                    width: 50,
                    height: scrollView.frame.height
                )
                rightLoadingView.startAnimating()
            }
            else {
                leftLoadingView.stopAnimating()
                rightLoadingView.stopAnimating()
            }
        }
        else {
            if delegate?.zoomViewerWillRefreshTop(self) == true, scrollView.contentOffset.y <= -50 {
                topLoadingView.startAnimating()
            }
            else if delegate?.zoomViewerWillRefreshBottom(self) == true, scrollView.contentOffset.y >= contentView.frame.height - scrollView.frame.height + 50 {
                bottomLoadingView.frame = .init(
                    x: 0,
                    y: contentView.frame.height,
                    width: scrollView.frame.width,
                    height: 50
                )
                bottomLoadingView.startAnimating()
            }
            else {
                topLoadingView.stopAnimating()
                bottomLoadingView.stopAnimating()
            }
        }
    }
    
    fileprivate func handleScrollviewdidEndDragging() {
        if topLoadingView.isAnimating {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.scrollView.contentInset = .init(top: 50.0, left: 0.0, bottom: 0.0, right: 0.0)
            }
        }
        else if bottomLoadingView.isAnimating {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.scrollView.contentInset = .init(top: 0.0, left: 0.0, bottom: 50.0, right: 0.0)
            }
        }
        else if leftLoadingView.isAnimating {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.scrollView.contentInset = .init(top: 0.0, left: 50.0, bottom: 0.0, right: 0.0)
            }
        }
        else if rightLoadingView.isAnimating {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.scrollView.contentInset = .init(top: 0.0, left: 0.0, bottom: 0.0, right: 50.0)
            }
        }
    }
}

extension ZoomViewer: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 縮放(isZooming)跟縮放反彈(isZoomBouncing)的時候 scrollViewDidScroll 也會被呼叫，這時候不要 preloadContentViewAt 因為這時候還不知道正確的 scale factor 會造成計算錯誤
        guard scrollView.isZooming == false, scrollView.isZoomBouncing == false else {
            return
        }
        preloadContentViewAt(index: currentIndex)
        handleScrollViewDidScroll()
    }
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }

    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        // 將最後的縮放值記錄下來
        scaleFactor = scale
        preloadContentViewAt(index: currentIndex)
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        handleScrollviewdidEndDragging()
    }
}
