# LZUIKit

LZUIKit is extension of the UIKit

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

```
let button = UIButton()
```

- Set the background color for visibled(default is clear) and disabled(default is gray)

```
button.visibledBackgroundColor = .yellow
button.disabledBackgroundColor = .gray
```

- Set the isVisibled to true or false

```
button.isVisibled = true
```

### Fluent interface

```
let button = UIButton()
	.setVisibledBackgroundColor(.yellow)
	.setDisabledBackgroundColor(.gray)
	.setIsVisibled(true)
```

## ControllerItem

## LoadingView

## OptionTextField

