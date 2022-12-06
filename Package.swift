// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LZUIKit",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "LZUIKit",
            targets: [
                "LZUIKit",
            ]),
    ],
    dependencies: [
        .package(name: "RxSwift", url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(
            name: "LZUIKit",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
            ]
        ),
        .testTarget(
            name: "LZUIKitTests",
            dependencies: [
                "LZUIKit"
            ]),
    ]
)
