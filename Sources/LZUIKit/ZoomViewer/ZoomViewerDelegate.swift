import UIKit

public protocol ZoomViewerDelegate: NSObjectProtocol {
    // Return true to enable refresh loading, defatul is false 
    func zoomViewerWillRefreshTop(_ zoomViewer: ZoomViewer) -> Bool
    func zoomViewerWillRefreshBottom(_ zoomViewer: ZoomViewer) -> Bool
    func zoomViewerWillRefreshLeft(_ zoomViewer: ZoomViewer) -> Bool
    func zoomViewerWillRefreshRight(_ zoomViewer: ZoomViewer) -> Bool
}

public extension ZoomViewerDelegate {
    func zoomViewerWillRefreshTop(_ zoomViewer: ZoomViewer) -> Bool { false }
    func zoomViewerWillRefreshBottom(_ zoomViewer: ZoomViewer) -> Bool { false }
    func zoomViewerWillRefreshLeft(_ zoomViewer: ZoomViewer) -> Bool { false }
    func zoomViewerWillRefreshRight(_ zoomViewer: ZoomViewer) -> Bool { false }
}
