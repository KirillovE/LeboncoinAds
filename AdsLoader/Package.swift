// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdsLoader",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "AdsLoader",
            targets: ["AdsLoader"]),
    ],
    dependencies: [
        .package(path: "../Models")
    ],
    targets: [
        .target(
            name: "AdsLoader",
            dependencies: ["Models"]),
        .testTarget(
            name: "AdsLoaderTests",
            dependencies: ["AdsLoader"]),
    ]
)
