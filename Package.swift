// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LZUIKit",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "LZUIKit",
            targets: [
                "LZUIKit",
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/coollazy/LZFoundation.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "LZUIKit",
            dependencies: [
                .product(name: "LZFoundation", package: "LZFoundation"),
            ]
        ),
        .testTarget(
            name: "LZUIKitTests",
            dependencies: [
                "LZUIKit"
            ]
        ),
    ]
)
