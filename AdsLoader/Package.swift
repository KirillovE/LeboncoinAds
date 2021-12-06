// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdsLoader",
    products: [
        .library(
            name: "AdsLoader",
            targets: ["AdsLoader"]),
    ],
    targets: [
        .target(
            name: "AdsLoader",
            dependencies: []),
        .testTarget(
            name: "AdsLoaderTests",
            dependencies: ["AdsLoader"]),
    ]
)
