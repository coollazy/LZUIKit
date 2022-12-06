Pod::Spec.new do |s|
  s.name          = "LZButton"
  s.version       = "1.0.0"
  s.swift_version = "5.0.0"
  s.summary       = "LZButton"
  s.description   = <<-DESC
                     UIButton extension for visibling property.
                     DESC

  s.homepage      = "https://github.com/coollazy/LZButton.git"
  s.license       = "MIT"
  s.author        = { "ven.wu" => "ven.wu.github@gamil.com" }
  s.platform      = :ios, "10.0"
  s.source        = { :git => "https://github.com/coollazy/LZButton.git", :tag => s.version }
  s.default_subspec = "Core"
  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/LZButton/**/*.{swift}", "Sources/Fluent/**/*.{swift}"
  end
  s.subspec "RxSwift" do |ss|
    ss.source_files = "Sources/rx/**/*.{swift}"
    ss.dependency "LZButton/Core"
    ss.dependency "RxSwift", "~> 5.0"
    ss.dependency "RxCocoa", "~> 5.0"
  end
end
