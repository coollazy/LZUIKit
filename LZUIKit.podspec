Pod::Spec.new do |s|
  s.name            = "LZUIKit"
  s.version         = "3.0.0"
  s.swift_version   = "5.0.0"
  s.summary         = "LZUIKit"
  s.description     = <<-DESC
                      Native extensions of UIKit.
                      DESC

  s.homepage        = "https://github.com/coollazy/LZUIKit.git"
  s.license         = "MIT"
  s.author          = { "ven.wu" => "ven.wu.github@gmail.com" }
  s.platform        = :ios, "12.0"
  s.source          = { :git => "https://github.com/coollazy/LZUIKit.git", :tag => s.version }
  s.source_files    = "Sources/**/*.{swift}"
  
  s.dependency "LZFoundation", "~> 1.0.0"
end
