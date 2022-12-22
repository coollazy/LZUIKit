import UIKit

public protocol ZoomViewerDataSource: NSObjectProtocol {
    func zoomViewerCreateView() -> UIView
    func zoomViewerNumberOfViews(_ zoomViewer: ZoomViewer) -> Int
    func zoomViewer(_ zoomViewer: ZoomViewer, view: UIView, atIndex index: Int) -> UIView
}
