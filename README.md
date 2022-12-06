# LZButton
UIButton extension for visibling property

# How to install

### CocoaPods

- Basic version

```
pod 'LZButton', '~> 1.0.0'
```

- RxSwift supported

```
pod 'LZButton/RxSwift', '~> 1.0.0'
```

### SPM

- Package.swift 的 dependencies 增加

```
.package(name: "LZButton", url: "https://github.com/coollazy/LZButton.git", .upToNextMajor(from: "1.0.0")),
```

- target 的 dependencies 增加

```
.product(name: "LZButton", package: "LZButton"),
```

# How to use

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

