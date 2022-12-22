import UIKit

extension ZoomViewer {
    @discardableResult
    public func setDataSource(_ dataSource: ZoomViewerDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }
    
    @discardableResult
    public func setMinimumZoomScale(_ scale: CGFloat) -> Self {
        minimumZoomScale = scale
        return self
    }
    
    @discardableResult
    public func setMaximumZoomScale(_ scale: CGFloat) -> Self {
        maximumZoomScale = scale
        return self
    }
    
    @discardableResult
    public func setDirection(_ driection: Direction) -> Self {
        self.direction = driection
        return self
    }
    
    @discardableResult
    public func setShowsHorizontalScrollIndicator(_ show: Bool) -> Self {
        showsHorizontalScrollIndicator = show
        return self
    }
    
    @discardableResult
    public func setShowsVerticalScrollIndicator(_ show: Bool) -> Self {
        showsVerticalScrollIndicator = show
        return self
    }
    
    @discardableResult
    public func setBouncesZoom(_ enabled: Bool) -> Self {
        bouncesZoom = enabled
        return self
    }
}
