// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftModules",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "FeedbackKit",
            targets: ["FeedbackKit"]
        ),
        .library(
            name: "FormKit",
            targets: ["FormKit"]
        ),
        .library(
            name: "LoggingKit",
            targets: ["LoggingKit"]
        ),
        .library(
            name: "StorageKit",
            targets: ["StorageKit"]
        ),
        .library(
            name: "SwiftKit",
            targets: ["SwiftKit"]
        )
    ],
    targets: [
        .target(
            name: "FeedbackKit"
        ),
        .target(
            name: "FormKit"
        ),
        .target(
            name: "LoggingKit"
        ),
        .target(
            name: "StorageKit",
            dependencies: [.target(name: "SwiftKit")]
        ),
        .target(
            name: "SwiftKit"
        ),
        .testTarget(
            name: "FormKitTests",
            dependencies: [.target(name: "FormKit")]
        ),
        .testTarget(
            name: "StorageKitTests",
            dependencies: [.target(name: "StorageKit")]
        )
    ]
)
