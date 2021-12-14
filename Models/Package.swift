// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Models",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Models",
            targets: ["Models"]),
    ],
    targets: [
        .target(
            name: "Models",
            dependencies: [])
    ]
)
