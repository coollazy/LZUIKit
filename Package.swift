// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LZButton",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "LZUIKit",
            targets: [
                "LZButton",
            ]),
        .library(
            name: "LZUIKit+RxSwift",
            targets: [
                "LZButton+RxSwift",
            ]),
        .library(
            name: "LZButton",
            targets: [
                "LZButton",
            ]),
        .library(
            name: "LZButton+RxSwift",
            targets: [
                "LZButton",
                "LZButton+RxSwift",
            ]),
    ],
    dependencies: [
        .package(name: "RxSwift", url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(
            name: "LZButton",
            dependencies: []
        ),
        .target(
            name: "LZButton+RxSwift",
            dependencies: [
                .target(name: "LZButton"),
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
            ]
        ),
        .testTarget(
            name: "LZButtonTests",
            dependencies: ["LZButton"]),
    ]
)
