# LZUIKit

LZUIKit is an extension of UIKit

# How to install

### CocoaPods

- Basic version

```
pod 'LZUIKit', '~> 1.1.1'
```

- RxSwift supported

```
pod 'LZUIKit+RxSwift', '~> 1.1.1'
```

### SPM

- Package.swift 的 dependencies 增加

```
.package(name: "LZUIKit", url: "https://github.com/coollazy/LZUIKit.git", .upToNextMajor(from: "1.1.1")),
```

- target 的 dependencies 增加

```
.product(name: "LZUIKit", package: "LZUIKit"),
```

# How to use

## Button

- Create a UIButton
- Set the background color for visibled(default is clear) and disabled(default is gray)
- Set the isVisibled to true or false

```
let button = UIButton()
    .setVisibledBackgroundColor(.yellow)
    .setDisabledBackgroundColor(.gray)
    .setIsVisibled(true)
```

## ControllerItem

- Create a controller item with controller name

```
let contollerItem = ControllerItem(controller: "ViewControllerName", nibName: "NibName")
```

- Get the instance of view controller name

```
let viewController: UIViewController? = controllerItem.viewController
```

## LoadingView

- This is UIViewController's extension
- Call `showLoadingView` using the view controller instance while you want to show loading view
- Call `hideLoadingView` using the view controller instance while you want to hide loading view


## OptionTextField

- A TextField with options showed with PickerView

```
let optionTextField = OptionTextField()
    .setSelectedOption("請選擇")
    .setOptions(["1", "2", "3"])

```

## TableViewEmptyMessage

- Enable the empty message in the `AppDelegate.swift`

```
UITableView.enableEmptyMessage()
```

- Set the empty message for each table

```
let tableView = UITableView()
    .setEmptyMessage("This message will show when tableview is empty")
    .setEmptyMessageFontSize(17)
    .setEmptyMessageFontWeight(.bold)
    .setEmptyMessageColor(.lightGray)
```

## View Corner

- Make a corner to the UIView, and all the sub class of the UIView

```
let view = UIView()
    .setCornerType(.halfCorner)
    .setCornerLength(10)
```

## Zoom Viewer

A viewer for display view with zoom

- Create zoom viewer

```
// A image array will show by zoom viewer
var images = [UIImage]()

let zoomViewer = ZoomViewer()
    .setFrame(.init(x: 50, y: 50, width: 300, height: 500))
    .setDataSource(self)
    .setDelegate(self)
    .setMinimumZoomScale(1)
    .setMaximumZoomScale(3)
    .setDirection(.horizontal)
    .setShowsHorizontalScrollIndicator(false)
    .setShowsVerticalScrollIndicator(false)
    .setCurrentIndex(5)

```
- Set dataSource

```
extension YourViewController: ZoomViewerDataSource {
    func zoomViewerCreateView() -> UIView {
        // Return the view you want to use
        UIImageView()
    }
    
    func zoomViewerNumberOfViews(_ zoomViewer: ZoomViewer) -> Int {
        // Return the total size
        images.count
    }
    
    func zoomViewer(_ zoomViewer: ZoomViewer, view: UIView, atIndex index: Int) -> UIView {
        // Edit the view to display the content you want
        if let imageView = view as? UIImageView {
            imageView.image = images[index]
        }
        return view
    }
}
```

- Set delegate

```
extension ViewController: ZoomViewerDelegate {
    // Return true to show the refreshing loading view
    func zoomViewerWillRefreshTop(_ zoomViewer: ZoomViewer) -> Bool {
        true
    }
    func zoomViewerWillRefreshBottom(_ zoomViewer: ZoomViewer) -> Bool {
        true
    }
    func zoomViewerWillRefreshLeft(_ zoomViewer: ZoomViewer) -> Bool {
        true
    }
    func zoomViewerWillRefreshRight(_ zoomViewer: ZoomViewer) -> Bool {
        true
    }
}
```

- Refresh Completed

```
// call endRefreshing when you want to stop the refresh loading view
zoomViewer.endRefreshing()
```



