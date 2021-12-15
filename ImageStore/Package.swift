// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImageStore",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "ImageStore",
            targets: ["ImageStore"]),
    ],
    targets: [
        .target(
            name: "ImageStore",
            dependencies: []),
        .testTarget(
            name: "ImageStoreTests",
            dependencies: ["ImageStore"]),
    ]
)
