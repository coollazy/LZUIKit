Pod::Spec.new do |s|
  s.name            = "LZUIKit"
  s.version         = "1.1.0"
  s.swift_version   = "5.0.0"
  s.summary         = "LZUIKit"
  s.description     = <<-DESC
                      LZUIKit is an extension of UIKit.
                      DESC

  s.homepage        = "https://github.com/coollazy/LZUIKit.git"
  s.license         = "MIT"
  s.author          = { "ven.wu" => "ven.wu.github@gamil.com" }
  s.platform        = :ios, "10.0"
  s.source          = { :git => "https://github.com/coollazy/LZUIKit.git", :tag => s.version }
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.dependency "LZUIKit/Button"
    ss.dependency "LZUIKit/ControllerItem"
    ss.dependency "LZUIKit/LoadingView"
    ss.dependency "LZUIKit/OptionTextField"
    ss.dependency "LZUIKit/TableViewEmptyMessage"
    ss.dependency "LZUIKit/View"
    ss.dependency "LZUIKit/ZoomViewer"
  end

  s.subspec "RxSwift" do |ss|
    ss.dependency "LZUIKit/Core"
    ss.dependency "LZUIKit/Button+RxSwift"
    ss.dependency "LZUIKit/ControllerItem+RxSwift"
    ss.dependency "LZUIKit/LoadingView+RxSwift"
    ss.dependency "LZUIKit/OptionTextField+RxSwift"
    ss.dependency "LZUIKit/TableViewEmptyMessage+RxSwift"
    ss.dependency "LZUIKit/ViewController+RxSwift"
    ss.dependency "LZUIKit/TabBarController+RxSwift"
  end

  s.subspec "Button" do |ss|
    ss.source_files = "Sources/LZUIKit/Button/**/*.{swift}"
  end

  s.subspec "Button+RxSwift" do |ss|
    ss.source_files = "Sources/LZUIKit/Button+RxSwift/**/*.{swift}"
    ss.dependency "LZUIKit/Button"
    ss.dependency "RxSwift", "~> 5.0"
    ss.dependency "RxCocoa", "~> 5.0"
  end

  s.subspec "ControllerItem" do |ss|
    ss.source_files = "Sources/LZUIKit/ControllerItem/**/*.{swift}"
  end

  s.subspec "ControllerItem+RxSwift" do |ss|
    ss.source_files = "Sources/LZUIKit/ControllerItem+RxSwift/**/*.{swift}"
    ss.dependency "LZUIKit/ControllerItem"
    ss.dependency "RxSwift", "~> 5.0"
    ss.dependency "RxCocoa", "~> 5.0"
  end

  s.subspec "LoadingView" do |ss|
    ss.source_files = "Sources/LZUIKit/LoadingView/**/*.{swift}"
  end

  s.subspec "LoadingView+RxSwift" do |ss|
    ss.source_files = "Sources/LZUIKit/LoadingView+RxSwift/**/*.{swift}"
    ss.dependency "LZUIKit/LoadingView"
    ss.dependency "RxSwift", "~> 5.0"
    ss.dependency "RxCocoa", "~> 5.0"
  end

  s.subspec "OptionTextField" do |ss|
    ss.source_files = "Sources/LZUIKit/OptionTextField/**/*.{swift}"
  end

  s.subspec "OptionTextField+RxSwift" do |ss|
    ss.source_files = "Sources/LZUIKit/OptionTextField+RxSwift/**/*.{swift}"
    ss.dependency "LZUIKit/OptionTextField"
    ss.dependency "RxSwift", "~> 5.0"
    ss.dependency "RxCocoa", "~> 5.0"
  end

  s.subspec "TableViewEmptyMessage" do |ss|
    ss.source_files = "Sources/LZUIKit/TableViewEmptyMessage/**/*.{swift}"
  end
  
  s.subspec "TableViewEmptyMessage+RxSwift" do |ss|
    ss.source_files = "Sources/LZUIKit/TableViewEmptyMessage+RxSwift/**/*.{swift}"
    ss.dependency "LZUIKit/TableViewEmptyMessage"
    ss.dependency "RxSwift", "~> 5.0"
    ss.dependency "RxCocoa", "~> 5.0"
  end

  s.subspec "View" do |ss|
    ss.source_files = "Sources/LZUIKit/View/**/*.{swift}"
  end

  s.subspec "ViewController+RxSwift" do |ss|
    ss.source_files = "Sources/LZUIKit/ViewController+RxSwift/**/*.{swift}"
    ss.dependency "RxSwift", "~> 5.0"
    ss.dependency "RxCocoa", "~> 5.0"
  end

  s.subspec "TabBarController+RxSwift" do |ss|
    ss.source_files = "Sources/LZUIKit/TabBarController+RxSwift/**/*.{swift}"
    ss.dependency "RxSwift", "~> 5.0"
    ss.dependency "RxCocoa", "~> 5.0"
  end
  
  s.subspec "ZoomViewer" do |ss|
    ss.source_files = "Sources/LZUIKit/ZoomViewer/**/*.{swift}"
  end
end
