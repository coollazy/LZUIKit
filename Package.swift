// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LZButton",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "LZButton",
            targets: [
                "LZButton",
                "Fluent",
                "rx",
            ]),
    ],
    dependencies: [
        .package(name: "RxSwift", url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
    ],
    targets: [
        .target(
            name: "LZButton",
            dependencies: []),
        .target(
            name: "Fluent",
            dependencies: [
                .target(name: "LZButton"),
            ]),
        .target(
            name: "rx",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .target(name: "LZButton"),
            ]),
        .testTarget(
            name: "LZButtonTests",
            dependencies: ["LZButton"]),
    ]
)
