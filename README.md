# LZUIKit

LZUIKit is an extension of UIKit

# How to install

### CocoaPods

- Basic version

```
pod 'LZUIKit', '~> 1.0.0'
```

- RxSwift supported

```
pod 'LZUIKit+RxSwift', '~> 1.0.0'
```

### SPM

- Package.swift 的 dependencies 增加

```
.package(name: "LZUIKit", url: "https://github.com/coollazy/LZUIKit.git", .upToNextMajor(from: "1.0.0")),
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

